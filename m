Return-Path: <stable+bounces-119788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B3A474FF
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DD3167D62
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404EF1CAA79;
	Thu, 27 Feb 2025 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxwZtu4/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E693209
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632594; cv=fail; b=N825U7BVjRgRrL5UMTrTGyztHG8PmyxRKNo9LMJjPoL6g9+cIp3clOSVIBIqWvm1dpdvATFUCtQULs/EQgb9qOr3oVTO8trZp456s09YytSsIc9WkWiqu1vGVwfNGbeqhqYDAnHrOyC5+/2FvNcb8+2diNFcv3XjsqoXK3FPlWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632594; c=relaxed/simple;
	bh=ceAHLjsUWl9l+V9aEVMiUCniNiZ/UgzkJjvqWS7LQ2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8NJ/OWBEG6nSrioKtT+pd2jVmFFXPhi+GRfvi/eD8Zl1ygrQDkCjFmLoEoA/iI/1XR9GbXPQM9j63s+K6/ovSJ0vs7z1GO8NNtwLsH3nZmkCIu82wo7WDOtaumQ94mSp6oWIDxarYVdQCaiF0BGf9VwD6MmUIR77QvNYlZek6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxwZtu4/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740632592; x=1772168592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ceAHLjsUWl9l+V9aEVMiUCniNiZ/UgzkJjvqWS7LQ2w=;
  b=bxwZtu4/ZVAeeq3oOgXXyaGUye65Nm075kOn+D9h/OEKCX0aWeuOMN+1
   BBeMvIjcYHZaK2PPYWEzPS0XjWxbSh8AvYELMV89j/TOy9DsLytBWMZWI
   G+D1tk8FKXTcyV7HHh5mHqVWaUQOkH2k4t7FqYiDLIhm3UiWKSKkL9m8W
   nrct5hyIA15dIEtR3Gko03cf8Mo36CoYVS5ux9aW7s6uU+w2ZT8QO4QLW
   v8zUWNtNJ8VXbsCwSaKkIUIwJVPflUETpmcFaKJ2paJEbSqwQFNbSumkk
   6sn9NAS1Kp2mEfIjGQYelA1AAq9NbJETi+CjwVIoF7fmI5cGbPTSh13CY
   w==;
X-CSE-ConnectionGUID: fJfGdaSNTUWKlF09VUs8dA==
X-CSE-MsgGUID: 6jR9FfMqR2K7sRBmCfCaCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58926619"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="58926619"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:03:10 -0800
X-CSE-ConnectionGUID: R3wq9Y/xTkuqBOLKPu/QvA==
X-CSE-MsgGUID: /kcvcjr1TWivsylUi5gyig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116687774"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:03:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 21:03:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:03:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:03:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRJCXdC4jWkm6Cz7wExpgbUxBLk0ipOcP1ckXKrxvyhYvJGUiPlJl3sq+OH7SEHrU1nr8F7fQvFix0i1hST+OVbUGpOcn3vVMZZRwAwjeUDPQsbTP4Jf7vbYYq3URGJPmRxJV8Uo7kBA1/8XSTLhZO+Kpv0wiTTd97BevIC9Jnp7OkJ+Px6lIINHACiacPF0CvhpX1/WPwxDzaZ3BU7ObXD54R52aZbeN3c9kV3eF6crUuq5uc0d05HMg9HLPL/p2eIs94csjryUWIs6HIFrvJEXcnXxbNN55up+BDYOUrGf1BtsxgfSDYvuR899PQ7L5FDGuXtuNUwXsUetHdeuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceAHLjsUWl9l+V9aEVMiUCniNiZ/UgzkJjvqWS7LQ2w=;
 b=jxMxkmc+PiFmSsujmeLRpTR3pecD1DnS5QYZsz2ErHWqfCZNDFARxa722SomXt3vGiGjFaGKpSjONlPTiPbl4ZhDW78MtbcNWPEhMYAyREdWRmA3M1/RWDIswJuJi2FhMIEnRP8K+Kq+tuHA1QadSD+fjmZw0cqGQERzelUc7ylnYYNUGd9bCyX0DmMpJ7fA+znk6wdmJ+RgdKZVXBYSFy9Mj1jdb4H+YhIjIdoAK0EKV9RaypgBmXQ222wlmhBaKTTfW/x0sqe/976FnsQHVJjYw9MI+vGlLm9KksB3hCgqQmK/IwQ3msRoMe9Kiw010ZDgaSIO9gpVRQjrDZKC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 05:03:02 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 05:03:02 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "Hellstrom, Thomas"
	<thomas.hellstrom@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Topic: [PATCH] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Index: AQHbiHJZukZf6cRoa0CKnqefe1ixqbNamLMg
Date: Thu, 27 Feb 2025 05:03:02 +0000
Message-ID: <SJ1PR11MB6204B1B8E2C4CADABD1063C681CD2@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20250226171707.280978-2-matthew.auld@intel.com>
In-Reply-To: <20250226171707.280978-2-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: 70ecfe5a-2aff-43fc-7e34-08dd56ec033f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y3M3RVN6di9aZzBwenMrWTNFRzA2MURva2d4SVBqbEthVnZrcTNXd0ZNSGYw?=
 =?utf-8?B?VDZjZmN0U3NiOG5abjAxQlQzcnZxQVM4aDBqV014S0Nuc0dWSjN0b0UweTB3?=
 =?utf-8?B?TXA1U25QWHFGYzdLRGtYR0JTNS9XYVpHQ3VoekFJRk1LdXQ5RkRIcUZReFRG?=
 =?utf-8?B?bU9zTSt2ak1EUkhQMlNCekNYMzM4My8wdTFiNklhblJQVGtXZndUd04rK0N1?=
 =?utf-8?B?WVRxNnhvSEU0aHl4WThVZ0hibm5RcVVNazhIdEx5V0VBVU5KNVlUOWhhcEJa?=
 =?utf-8?B?bUd5dHVvcVZoMUFjN291ZS83c3dxblVtaVA5UVdpYkk3Sk5QbVVNbmNnbjRS?=
 =?utf-8?B?NzJ0Mi95aEhXbStxSnpkVzdqNkxBSnVoVmhiTDljRkJYZUNKaVEzNTBTSkt2?=
 =?utf-8?B?cnNFSDBuQUZEbjVnY2VMcC9qN1Z5VE44ZUNFa085bVdCU0I0YjdvckVjRG1k?=
 =?utf-8?B?VkwzanBuUEFMY0JqZk9xSEQ0K3RnejlzSVFOeFdCdW5GUXRFSmRVbFBnNFlv?=
 =?utf-8?B?L2hiVU1RSDdqLzk0c2pJbDZsZlhPWDd2aTBVS2hUMGVDK2ZqRWt6Q2NLaXd5?=
 =?utf-8?B?K3pQdWYxWFQ2RThxdGZUS1R0Tnh1RGZwNm9UajNOclo5anVHTG1sME9QUGVE?=
 =?utf-8?B?WWdHN2VXWTlSUCtyOGNtYkIyejVqQTdXekpib1lvQjdoUEJpUE1ocHVJQ2Mz?=
 =?utf-8?B?QmRVMFVvTkQwaHlpbmFXdFdva1JJNWVUbTh5RnNsRHViTkdRRGdrVDgxU0JN?=
 =?utf-8?B?Zkw2dktMUCtsMUFjVWQyZ0FlejRPNXRBNjlBbSs3NzJiRGYzenNYMmFuakxU?=
 =?utf-8?B?S1RiQ3BpZE1ZN05jSkxjbUFRWEhOZVRpU0ZWdktpSkE3R0F3SzROSHc2cURI?=
 =?utf-8?B?TkZ1b3A2OTU4b0w0akFrS0hQV0dvZmdPMjhTYkRva2lXaXlySDMyQ3R0bU9U?=
 =?utf-8?B?YjM2Vkw5NkZVSnN4NDNkSWhKWWxOQU1WcTBSTzg0SUZrdWlncHRWWFp2L1h3?=
 =?utf-8?B?OHJzMVZ6Vnp3TkVvQXdIQTBNeUxFcXp5K0FpWnVrOFRvUmdMMEdXMUV3TWZr?=
 =?utf-8?B?bHJnUUJ1ZC9MQVFhMjd6NUEwTDNRTmpKTmxGTlBNcktGZ1hNdlN2OFd4YWgr?=
 =?utf-8?B?aWYxc0JTdmFBaG02eHlCVGl5dFdKekhveUcrcWg5TzFZZGhFSk9tbkVPNUlm?=
 =?utf-8?B?aDF0dEFPVE42ZTNucGgwbnBaamdNSzUvMHpDaFFINk9xWlErbGVodXFlRzZQ?=
 =?utf-8?B?NmEwUzlhWFlCcEZhV2dkRDYrYnNTSW5jWjhmL04yN29BM2wvcFI2dVJHa05Z?=
 =?utf-8?B?Y0s4TXNjRm5ZU1hxMWE0WUlabFVSSGRNR2pIL1VqWGNKR0NoZHRlbzc1WGEv?=
 =?utf-8?B?bzREY3MyOGFGaVNGMXV0SzRhUW9FYmlLVXBrSTVKTlBHUEZwT25KWUJDdWto?=
 =?utf-8?B?Ung2YzFUV3lkM012WGRhVjZqc1k0b0xFWTVPQWt2bXVuUWt6MjdPVkNKdXhC?=
 =?utf-8?B?NnpZK2gveXJDUVRxQ0dPN0lNb2lxWVVXNklTNERGbjhnN1Y3d1JLa3RyZ2VO?=
 =?utf-8?B?QUhlUnUvYUZGUHlPUlFpZ0luRStXeUxSYVpaOFczZWdNc0M0VnFJaFBLbm1z?=
 =?utf-8?B?KzlsaldUNGNZRjNrdW11Ulc3VHhBZWZqS3d6ZE1Xb3ZYYWhuZUtHTHJOSVdl?=
 =?utf-8?B?aDVLdlBXOXM1SGtEZm1NNkZMc25TMWcvN2tZSitLVk9CcEF5VXhFWWk4WjFS?=
 =?utf-8?B?OWVSaWc0bTBGeXdJNGpXbTlMT1pXMFRUa0dSbGRDL2VVUGhWRktieEU4bURP?=
 =?utf-8?B?WTNKMVEyeEs0OFR2RUpkSEdlTWtMekhBME02WUdXM0hLTjhRb2hLdUppN1BT?=
 =?utf-8?B?a2xuem5rakZxY3NHVTRRZ1ZkSmJyVU53eG9qRjIyTmdZb1lXZDFLblVHdWxr?=
 =?utf-8?Q?d5+qoCdskbeitpFfvjmuDMRLlBI90i7t?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFlFTWI1OTNwdkVNSjhzY0hkeWxhT1U3VnlBRDMzTDA2ajJNdU5sZUtCRU9n?=
 =?utf-8?B?NllRaG5kVElJdk45ZS81aUpHTmdqS3prc2oyQjNIRXRSb1dRVmVNS0VFOUZ2?=
 =?utf-8?B?dkVobVJWUk9MdHZVZGlkTzNSMVlncGpwTUtRUjNsd2FMeGNraUVsRzBsWmdM?=
 =?utf-8?B?S0czUWQ0bU0rRmJOSjhWcURkd1Q3Q1MrQjZXK0F3dEpMd2hPa0ppeHNDUktz?=
 =?utf-8?B?QU5RTjA2NmFGYk8rNE9vVUtuTnJIYU9IblFSTWpZdXBpdXd0RVpDNEE3ZzBJ?=
 =?utf-8?B?QklycTBRTWppY3ZoT25KYXlGeDZWTS9BcDdiZi84QUtxTWtBdFZaSDZITFBM?=
 =?utf-8?B?S2tOZ2ZBUTJGZDhMZEd5NUlzN1Z3TjRXNWJCbFZUOTltK2U5YWJnSFcvVUJn?=
 =?utf-8?B?dVk1ZlI0VTF2dUQrTTN5bkV6ei8wNW1QSHA1ZzYwbE1va0V1RVUzYkxnWW9w?=
 =?utf-8?B?V0g1NFl3dGdvV0x0a201Q0dhRmhsWE5teUpjbUF1Wi91YitPSkxZcTdZZlVq?=
 =?utf-8?B?d1EzVWdCKzVMVnM3QWhHMnMxY1NYaE1rNmpnSTJjeG0wNUZRdVVKL1lBQlNm?=
 =?utf-8?B?T0xVVkc3eHRzY1RwZ0F0L0IyQTFZMXBhbmFHa09oYzNZdWQrSlJjUTg2OWFP?=
 =?utf-8?B?VmhON3hXTG9IemFHQ2xzQU90aC9lcU1jdVZRS3ZVQndjTktsdVFhZDRIckhO?=
 =?utf-8?B?TVdKMjg3aW1CdTVCZlRDaU9MMSt5aklRcmZrR21sdVFBdGIvKzJ5c1lHSFJ3?=
 =?utf-8?B?SU53S0VMTXRRZ1FraHd5c2ExYWlLZWovbDkwcndDVXpaTGpBR0pSWjRNaWpo?=
 =?utf-8?B?OTFWOXR3b2ZjM2xML1R0eXFOR01YZUJqWjBiem84Uk5OdFZTWG95RWIrTCth?=
 =?utf-8?B?M21aTTVDZVB2SGxJa3NNTXpwdXhFZ2NBUHhHMGFhRUgrRW5BdzJLRE9WZWpT?=
 =?utf-8?B?OHhSeW1rRHpWRzdoLys0WnJOOTBwbFJkS0dyWjRqRmRDTWdFcDMwelpyMkRM?=
 =?utf-8?B?b29IVURHM1lOd0RvVzJ5QkN6QUZhUy9vQVl6MU1jTXpnSzk5ZmV3NTllMm9P?=
 =?utf-8?B?WFpRU1RvSXRyODRMRlVzdFVBUU5IYnFvTGorRnBLeWIySDdremlOZ2YxcERS?=
 =?utf-8?B?Vm1YVHhYZHVYOUIrUS9CK1k3YXM0ZEN1RHJIU2luWDQ3RDd2SkhLRzEwNEdp?=
 =?utf-8?B?RXEvVGkxNUhjV1RJUk80MFY2L3hpNXIvamVYWXFma3kvZ01mL0FZTDhGU1pm?=
 =?utf-8?B?ck5ITnA2Y2F0MkVHTGVVZ1RMRTUzc1dCSFI2bk5ZSXB2elRYOTFmRVdRbTRj?=
 =?utf-8?B?V25uaDIxbnFpT0UvMkV0V1BVc0RGeC9La3gzc0FxS2hNVlhNVEU1WXErUzJN?=
 =?utf-8?B?ZkIzWnYyNDFHS1BFa0svM3dWdDJrNVY0MVdVVFZ0VDBmcGlDQVBXRDV2NzBR?=
 =?utf-8?B?TTRWVG1UcHo0cGMvcXFaV2dzUTJ6VGlyL2UyaU45aWJzSklqUmpwQXdwV2pr?=
 =?utf-8?B?QVpPdjB5ZlVBRWgwSUhqV1g1NTllZkMrVVp0V3BtTXdkTkcwUmwzWlJHaHMx?=
 =?utf-8?B?SFJ6Uk51ZmlvVHJsM1N1NnZrMk9UNlI0N3RpYzFGWVZHR2g4RlFDUjdpbmdQ?=
 =?utf-8?B?dUdhN2hXMytyMnk1dE9zUHRCcHZPWm5ta0VGWEphTEpLelh5ZVdaUnhPYzcr?=
 =?utf-8?B?L2hjWjJEdk5lRFNUQVdVYXdKSU56L2o0UUFZa2ZwUStoeTdwLzJpaURFNzhW?=
 =?utf-8?B?eDgvOW10bVdFS3JTanpSVHZoNmlueGVLY3o3L0RIc1orTFpqalB6QWtZNWI4?=
 =?utf-8?B?SGxuRXB4MWpHakp0NGt5UEQ4VWtIRTk2RDlLdFRncWdRTmhBMGdWd0V3Q2or?=
 =?utf-8?B?Nldhdyszc0R6V2VuamxseVk4UnVlQU5yMFk5M2ZiYnFBdHQyaU8zblBVN1Jv?=
 =?utf-8?B?T3VIVmlzTzdZdDhkQkt4SnZOTUdwaXNGQlR4N0tPWUQyYk5tRG1aNWxvQWVs?=
 =?utf-8?B?bnNIZXAzQVdYR0tjRGJURUx0T3dGcW1vU1JTMjR2bjc4ZERXU2psUk5xTXRu?=
 =?utf-8?B?R00vcE5tSk5EMUdYN1prdDNSd0NKRVlSWkl4UTdINldISVJ6OVNTWHY4c28x?=
 =?utf-8?Q?ljjqeXkRTv+26GJvgTuOyMJDl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ecfe5a-2aff-43fc-7e34-08dd56ec033f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:03:02.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X287dDDOVWBh0GatQitpBrGNHYXAZmZHP3XJf2MjZCgRW6AJCeNCMgJkVsnGh7mqso21HF9Yj+QLYMNSwWnNgh8bHd/E017gGuVzqfgJtws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwteGUgPGludGVs
LXhlLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gTWF0dGhl
dyBBdWxkDQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjYsIDIwMjUgMTA6NDcgUE0NCj4g
VG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQnJvc3QsIE1hdHRoZXcg
PG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgSGVsbHN0cm9tLCBUaG9tYXMNCj4gPHRob21hcy5o
ZWxsc3Ryb21AaW50ZWwuY29tPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
UEFUQ0hdIGRybS94ZS91c2VycHRyOiBwcm9wZXJseSBzZXR1cCBwZm5fZmxhZ3NfbWFzaw0KPiAN
Cj4gQ3VycmVudGx5IHdlIGp1c3QgbGVhdmUgaXQgdW5pbml0aWFsaXNlZCwgd2hpY2ggYXQgZmly
c3QgbG9va3MgaGFybWxlc3MsIGhvd2V2ZXINCj4gd2UgYWxzbyBkb24ndCB6ZXJvIG91dCB0aGUg
cGZuIGFycmF5LCBhbmQgd2l0aCBwZm5fZmxhZ3NfbWFzayB0aGUgaWRlYSBpcyB0byBiZQ0KPiBh
YmxlIHNldCBpbmRpdmlkdWFsIGZsYWdzIGZvciBhIGdpdmVuIHJhbmdlIG9mIHBmbiBvciBjb21w
bGV0ZWx5IGlnbm9yZSB0aGVtLA0KPiBvdXRzaWRlIG9mIGRlZmF1bHRfZmxhZ3MuIFNvIGhlcmUg
d2UgZW5kIHVwIHdpdGggcGZuW2ldICYgcGZuX2ZsYWdzX21hc2ssIGFuZA0KPiBpZiBib3RoIGFy
ZSB1bmluaXRpYWxpc2VkIHdlIG1pZ2h0IGdldCBiYWNrIGFuIHVuZXhwZWN0ZWQgZmxhZ3MgdmFs
dWUsIGxpa2UNCj4gYXNraW5nIGZvciByZWFkIG9ubHkgd2l0aCBkZWZhdWx0X2ZsYWdzLCBidXQg
Z2V0dGluZyBiYWNrIHdyaXRlIG9uIHRvcCwgbGVhZGluZw0KPiB0byBwb3RlbnRpYWxseSBib2d1
cyBiZWhhdmlvdXIuDQo+IA0KPiBUbyBmaXggdGhpcyBlbnN1cmUgd2UgemVybyB0aGUgcGZuX2Zs
YWdzX21hc2ssIHN1Y2ggdGhhdCBobW0gb25seSBjb25zaWRlcnMNCj4gdGhlIGRlZmF1bHRfZmxh
Z3MgYW5kIG5vdCBhbHNvIHRoZSBpbml0aWFsIHBmbltpXSB2YWx1ZS4NCj4gDQo+IEZpeGVzOiA4
MWUwNThhM2U3ZmQgKCJkcm0veGU6IEludHJvZHVjZSBoZWxwZXIgdG8gcG9wdWxhdGUgdXNlcnB0
ciIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNv
bT4NCj4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0KPiBDYzog
VGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AaW50ZWwuY29tPg0KPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTArDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2htbS5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMgYi9kcml2ZXJzL2dw
dS9kcm0veGUveGVfaG1tLmMNCj4gaW5kZXggMDg5ODM0NDY3ODgwLi44YzNjZDY1ZmE0YjMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9obW0uYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0veGUveGVfaG1tLmMNCj4gQEAgLTIwNiw2ICsyMDYsNyBAQCBpbnQgeGVfaG1tX3Vz
ZXJwdHJfcG9wdWxhdGVfcmFuZ2Uoc3RydWN0DQo+IHhlX3VzZXJwdHJfdm1hICp1dm1hLA0KPiAg
CQlnb3RvIGZyZWVfcGZuczsNCj4gIAl9DQo+IA0KPiArCWhtbV9yYW5nZS5wZm5fZmxhZ3NfbWFz
ayA9IDA7DQoNCkxvb2tzIGNvcnJlY3QgdG8gbWUsDQpSZXZpZXdlZC1ieTogVGVqYXMgVXBhZGh5
YXkgPHRlamFzLnVwYWRoeWF5QGludGVsLmNvbT4NCg0KVGVqYXMNCj4gIAlobW1fcmFuZ2UuZGVm
YXVsdF9mbGFncyA9IGZsYWdzOw0KPiAgCWhtbV9yYW5nZS5obW1fcGZucyA9IHBmbnM7DQo+ICAJ
aG1tX3JhbmdlLm5vdGlmaWVyID0gJnVzZXJwdHItPm5vdGlmaWVyOw0KPiAtLQ0KPiAyLjQ4LjEN
Cg0K

