Return-Path: <stable+bounces-161628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DDCB011E2
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 06:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0912B7B0309
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF141A08CA;
	Fri, 11 Jul 2025 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2kDIkgR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16938F7D;
	Fri, 11 Jul 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206528; cv=fail; b=Jd7xsiBKraZ3QBbgyFCOwdm7IwRwM6xjKXu+k2IVfJaKSeoPADFvUjWKn0BURsQWC/nUBZ+OcgwmkCpXdz5roeyOUqhrmpHTX1USEgAqZ0DTfYZYaHwmaZ3apyv9cCS9/0D2sgKLdpVpyWCRzlS/kOBTcbta6SehQqaNIR2X6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206528; c=relaxed/simple;
	bh=o73rFyTLbZExINQIKfPYNd8v9Yz7PEvGncIksLslxxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgpwrjAKJ3awEmiCVJXMryA28CNZSpsR5Y0Cx1jRPOhs9z1QJa7xamEJBXuw+EamILU8hw7jdwXayfThcpsSpLfeWqonbDpzvR0c468LtKLbizsPMkzJg1irPJwTLoWRznp02eNPb+oaj/5sXhHDwfwHG+b+duzhC50bXcBmdHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2kDIkgR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752206527; x=1783742527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o73rFyTLbZExINQIKfPYNd8v9Yz7PEvGncIksLslxxg=;
  b=U2kDIkgRFWvKC325nZkAXadq+CA+uNP9jTCxk/cToy19lKgUoK9UbWaC
   tDKTGwYVt9KseADR99zvP28u/mOqQ5wyo3xTnbLFwsRngH/KzC1bIkQvI
   +Tj/qGO1c2iv6w1YQ+HwcHESkWsPCygYFCNw28togpb/fS7AAlqJuYKmb
   QJCAI+BCm3L6bdthKj9cZWSb+hSTaQ3FuAV4JgopwioU8I70ryWkwcd2P
   scSSQpSqEOWdaXDW7+kaXw3puQX+M9tHDeBcdM9wFIPY2TsTeBVNrcxO5
   0xMwjuNL95q1vYM1swpjegB1EqTpkuSVkk0uR9Be9K6M07l+q6E/wG9QZ
   A==;
X-CSE-ConnectionGUID: 5bmB6bHASlyvy4oakACBmg==
X-CSE-MsgGUID: hSGZTP9CSGe2wQANT8tW4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="77045780"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="77045780"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:02:06 -0700
X-CSE-ConnectionGUID: yghyw1ioQbyzyUnc3ATUew==
X-CSE-MsgGUID: Od2uJH/dRcWR/wOuvU0DNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156995177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:02:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:02:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 21:02:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZmrvKZ3TSzWoCc7ukIDbw6Ot8Ehv6CMn3wtBBqKHqiWIMxWBAAg0nCsYs4P1QLVD4kvJBiA/6txyEoM+IDu4rQYhz2sqKSKfq6r2QI3eOyAGKe70dWC6wcyjmpHrdeaDnz8E9XVhE5EL0tVvJX0q8SWiIwyzBwxBUvceVCWfjNQ9z3auWmEUp5NpGbbbemKLQ0ITwui/nG85txLt6AUqkSl4HP4t4NU7fXa3U5+DlJ5UIvTmQr+2RccrMwIDbmYok5yiPRB2g/C8N5aP3hlO66pJQfX0ceSXRHelT+qdGGA3ZhqShOrJY9DVexHCSqTcODotTNLqfeVSPKQy1YNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o73rFyTLbZExINQIKfPYNd8v9Yz7PEvGncIksLslxxg=;
 b=zLq+EmGtgslFcHL9CTFJWVD+gm/00135rNcuwM7891EpnWe7gqp3eep6o7cg6Syo2mZOtFA2ascM668CzAYf8eFFUPbFwUXzcTfUxdGOjMqPXzVU08XnTzy+C8fwRF6r2egvLR24VZ2gXrayXShi2l06xP6Yss9vW1OxqHXBKJdIgznVRixFrwEjuzPl4+8sWAjBhiVPwfH/IrM3b29zY2MKDgX3vZ53hUVZxCGOU0XjTZjr220bUo9NSVktZbxHe04YfShKj2CShyNc5GCuqbOiKSi36O/u0Pxw2CEPHvWCaSZExHAp9hCxMfkhva5nN+mlpF9PuWYrndjAG+tXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 04:01:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 04:01:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQrYxwAgADbfACAABA0sA==
Date: Fri, 11 Jul 2025 04:01:08 +0000
Message-ID: <BN9PR11MB527679AB260190162007F2018C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
In-Reply-To: <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8320:EE_
x-ms-office365-filtering-correlation-id: b97c1bbd-ad0d-4660-d9e4-08ddc02f90e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cm1EK0ZzZCtYWE5vbTlFMEFCd1hCSXpVaHBBLzMyVjJ3NisrYkZFb0NRUlI2?=
 =?utf-8?B?MVJIb3MyRzc5QUVvT3dsdXlaL2o4ZlEyZWZ1ZmFibktZMmJlQjBwQi9Fc05k?=
 =?utf-8?B?SW84ZmRhdWFvdkZPdktmTVNlOXB5OTdQSVdoV1lrOE01QTJwVWpJZXVRZUl3?=
 =?utf-8?B?TzFtS1N3anZ5TjQxWWU2dzJNOFVUM25MZlZWYXVTZzNHdnY4aDF0alJEQ05U?=
 =?utf-8?B?VU5odksweXllNE1ncm55MUhzaVkrNE5vWFV0ZTFyYWZMMEFpdWY5c0VoVVh1?=
 =?utf-8?B?ZGRnMzdKbXNtOEFFeVFWcEM1d0c1bzVzWUwyME1JMmU0algraENjZ1VrL1Y2?=
 =?utf-8?B?ZSs4b3R6R1krQlhnaTZpejBqV2RZZ3BCcnRhcmcvb3Mxek1IekNwSEVNZG51?=
 =?utf-8?B?QzkvMUhINFhDcWhMUTVnRnpHcjB4UENkWXNtaXNybGtQZEZORldLVlBIQnF1?=
 =?utf-8?B?S2tKMUN2ZTM3T2JENHV1bDZBamN1WjJMNFVhKzU2ZXZTMXU4ZTV4S0hlcDlN?=
 =?utf-8?B?cmV3cFQxc1lPVjFmb3JISjhpYzRIeGdTMjNZZ3JaL3hwVmpUWHpCQ3UvVDVh?=
 =?utf-8?B?bnpITStWdXhKOGs5VXJqbTFZM3djSFovREZSYlJOVnE3RmNmYUNRUDlteDBl?=
 =?utf-8?B?L2Yva29mSUhwRDJ4WmI2S1hCYktrOEpoZGw3MkNzc2czRHZheUdGczg4OEc2?=
 =?utf-8?B?NlRTYlRIcGFkT0RDK3JCMXlHWVRtaUNGd2F3c2cweERmVFFZbkI0Wk1maDlo?=
 =?utf-8?B?MWNXRlZ0b29yK1M0Q3VnRll6TGJtVnZkcXkrQy9DTW04UEdnSXJTblg2czV5?=
 =?utf-8?B?VUtSNEgyejlzUTVhd2pHanFid205dThlLzR1Wjd5K0swNkw0SDVUdVR4c1Ny?=
 =?utf-8?B?dDBCSHQyUFBrbGptM2tjSkFIRFlQRkZnREhLQmNPRlp2Y3QvOUtKdWFWT0hj?=
 =?utf-8?B?cjNHckVlY2RzY3FUd2Voc3ErTTdHNE03blphMURMTFlPZFBSSmpuanhoTGVu?=
 =?utf-8?B?K0htMjhWU1NuQ3k4WHJPSzliQnVIWmtmc3V3bE53K0xtUjNoSENFeER3QzVC?=
 =?utf-8?B?WlBBbkJvY1BkUWs2UnQrRHFwVllYbmNweVlPS1JHYzdxdVRzS3lOUS9tcEd1?=
 =?utf-8?B?b3NscURIdm5SL2ZpbFpkZHV2aTN0V0gxalpqSGhjZGFMekpSTjFKS2grR1Fo?=
 =?utf-8?B?cVBMUXdudFFLQzBOcHpvbGlSZ2F6ZnJHQ2ZGaThzMjFrYlpmY3lLaFYxM1hz?=
 =?utf-8?B?M2dhUW1ocnl4TE9lMU5DZEpXQ0RxOElWbXFiZkIyNHhZRXNsZi9ETHNudExX?=
 =?utf-8?B?SFhITFV5THFLTWdHZk5aM0pVNng0b2ZRUFRDZy9xc0duR0pRSHV1aEprZk1u?=
 =?utf-8?B?ZkZ2RlRYOTVBQlZPUDhjMWZiVFV2em54dDlhR0hhcTBlcjBld0oybmVqYTFs?=
 =?utf-8?B?WHc4ZDRnRDZFOXdTTGhmTlRSSFZieFFUVG1Hek9HRjQxeTAyL2JZdEFxc2RV?=
 =?utf-8?B?SFhDZkFtQ3VhbkNPUldYeGNFQzVPOVFrNmU5eXJiZmU2Z3dldFRUTldvenRv?=
 =?utf-8?B?K21vQVd3cXhpZmU1S2R3d3hiR1ltODhtbmtMRHI1bDhjdnhCWm12UFVMRUJY?=
 =?utf-8?B?SmdWN3FCc2l1WGt6RFZ1eFBaenMwbVJHT3JnNmRjRVZnWHhmZXdrZW9relcx?=
 =?utf-8?B?VEloNTljVVZaRDBnTjVxUUtzWjR2S1F6S0xoeXdWTWVPRVRvNW10Q3FVSXZ6?=
 =?utf-8?B?aHhIc3ZRaEtaUTVVZGZKcTFDTEVCQnQrd0tTQVhSeURJSi9CRTc5cnVsRkxu?=
 =?utf-8?B?Z1QwcFA4L2NmSDFIcGFBSDVmWUpQeWNBTVYvNnJrcXFURWJXaXhHbGI2R1cz?=
 =?utf-8?B?TTNNYUJTWFo1cE9aK0g3bDVYZ2svbDhHM3VtMGZsZGlBQU96T04wMnNERWVT?=
 =?utf-8?B?WWlzQ0NJRjV5QVE2aEZFOUNOelFkOUR2VSsxZ09oS0NGbVhKN21vZExMSTkv?=
 =?utf-8?B?RHFMTUcwaTNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekhwSGJHeFNUeUFVOGZmOTBaZWMzVWJLWnBUUFNFNkRSclhqQlY2R1hNWkhq?=
 =?utf-8?B?MU1sc2F3bXpsWk12V1pvdDloTUxqTTVFQ0ZpQW1ZSFZSZHVOS2VMRVJ2Sk1v?=
 =?utf-8?B?Y241eXJXQkI0LzQ2Qncyem45dU1URGYyK3BZUVRTZGIwdjFBYjBlUWtnUVYr?=
 =?utf-8?B?M2VsVEZUK0tZeXNsY1ZXR0daUkExdVk2UFQ4T0VyU1o4cG8vUW9yVlg0ZDN6?=
 =?utf-8?B?UDZxU3FNbkpkQVcrV3d1OWVZVjZjZkhURWVPZlRYdTA3OGVKbGJpdWIyRGx4?=
 =?utf-8?B?ejlvRktlUDA2cDFCWmdMbWttVndkeGdXMHVGV1hJRnQwUkpERFM1aTNDUWds?=
 =?utf-8?B?WDE2VmtISGk3SHNGVXlYLzEvUk92ZjJreDFKbEI2eW9lS0oyUUlHRC9QUk5O?=
 =?utf-8?B?aDRTWHFTaVJpYzcxRUt4anY3ZGlhMWtycmtEZXl6aTM5ajJDZnJGYUdmVEgx?=
 =?utf-8?B?L3VaRGVJSUVPUm5kZzNQU3dFcnJ1VXd2ZjFWN3NpNDFScm5Vczl0SEVLQUNJ?=
 =?utf-8?B?Rzc0TzdOWkQxWDYzMWdFdHNoNElQV09ydUZpRGo2ODVkK2J0R0IrNzJ1SkIr?=
 =?utf-8?B?NWR0b2VnOVJjdE9ZUlQwY1lkUThEbXQ1UWpDU3BDemY0UmQ2ZlJhNnd0WHVu?=
 =?utf-8?B?aGFIWmxvcU0xMFh4N0s0dFV4SGgwWHdLcnRVRDJWY3FBSHladGxmanFxZ1dU?=
 =?utf-8?B?cVhDTjJVNVUrQVU4RlFVR1kzM2JWSTgxK0xhL01QUVFFNnN0MHZCNEYyV0w0?=
 =?utf-8?B?enNnR2E5OStJU3hIaGEwbkNuQmFFdWJKeTFwY1IzTmRKL3pubGs4R2ZncTRR?=
 =?utf-8?B?TEM0cmNDT2Z3UDRpVjdZazFhb0lVNmhKRkVyWGRjOWZMSzJiVHdJNGRMWXBF?=
 =?utf-8?B?RldwQlc3VVFrMGdob1gwSmxIaU9KYnJHUUdhd1c2cUY1Z2ora1ZFRVdRRENC?=
 =?utf-8?B?UGFoVmVzTXdkUGRBa2FXWFliaytzUk9iMnZYUVVzODRSQWNXb2syK1Z0ZkpR?=
 =?utf-8?B?ZHlMeWhpd2RGa0NTN0pGaDBBSzlkOE1VY2UzNjRMcVpzcnduUVhJT3BRam9J?=
 =?utf-8?B?dlkvcXltWHJlV1BGamNhWEZMdktoYU1JU1lxL3hxcjJPMXFSNitlUEZlZ2lR?=
 =?utf-8?B?QlBvTFdFdlF1UWNnclZFVUYrZGZYUnJCdWRNbk44NnVReU4wOUtGNGJGbW1i?=
 =?utf-8?B?bDJNUEUyblh2OXpKYVZZclVyaXlETHY1ejhINXdMaTdpYTF2R3FnOEIrRStp?=
 =?utf-8?B?bjIyeUlMQ3ZWdXRhc2MyWjJuK1I2NEl5Z1hQbHhscEZoN0VPRFd4VDJjbXhQ?=
 =?utf-8?B?cHU0VDVPQnZFSEZzRjNwZjNnK2dGZGU2Q3lsZE1qdVkzd0ppVFArckR6UGVH?=
 =?utf-8?B?bkIwUjF4bFFkY0kzN21HZHdOVFViT3hFaDZGazRZVHpJMmtqQzhYZXFyeGNr?=
 =?utf-8?B?YkFRZUlpNGtsenhuYVpxQnBSeVNYWWpVcU1GRFRUZzFqQlprV0NrblpuNGlO?=
 =?utf-8?B?TTR3NGFxUU1iTDBJSzM2ZHJkdXVySjdEMXhtc1haRkdnQnNneGsxL0lkWDhZ?=
 =?utf-8?B?cE0yMlZPN0hoNGJQOFpndi85SExYaWlVSTZQSzBOVU43L0lSck9tRVJDekhI?=
 =?utf-8?B?SVFwakhyNHdaWE9Ic1NpMzZJdVVJSjhxVk12N1E1Z3BWbjNDUDBKRzh0OURW?=
 =?utf-8?B?akk0eEtZWlk0U29xSWhROUs5bTZvUEltYjUvbDFUaG5aOEJPWlZWaG8zQ2hX?=
 =?utf-8?B?WDlDQUw2RkdHZzl1QnBNeXJCWTNmcjNzaGdINGZxcS84WGJjVFZWZkZJSGEx?=
 =?utf-8?B?TzRqSjRZYy9hd0xhd200NFRPQUV2TUF2RmhPRTE1T0Vud016YzNzdGE4UW5B?=
 =?utf-8?B?NFBTaWZSandsaFF2ZE1IOGNNUHhzdTdhVFBMVlZDTnQzaVJlTjVzWG5Qd3RK?=
 =?utf-8?B?azJRa0lkMXExYU9tUUwyZjgybUZ6NUJwaWtvNU4wdXFEY0VZem1vYy9iQkFy?=
 =?utf-8?B?YnJDZGtFbmJBTmxWRmQvK1crbEkrc1h2aEkvVWpGZ2hScHpNL0FNMldSZkRP?=
 =?utf-8?B?Nko4YmRXc2k4VGMrQVB6VFNTbGd2YlNwbkN0a25XcjAvc1NpWFd4UmJ3YU5y?=
 =?utf-8?Q?YGb6QR4E+4l65zB1Km8pVZcEF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c1bbd-ad0d-4660-d9e4-08ddc02f90e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 04:01:08.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rre68Goq3XAPGvWy41CGnOYgsUzQvBffkZtAYCB0os4EcaIrGOrYalwDI2MNjFi9W+ikStT6vXtW17xjvqTW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTEsIDIwMjUgMTE6MDAgQU0NCj4gDQo+IE9uIDcvMTAvMjUgMjE6NTQsIFBldGVy
IFppamxzdHJhIHdyb3RlOg0KPiA+IE9uIFdlZCwgSnVsIDA5LCAyMDI1IGF0IDAyOjI4OjAwUE0g
KzA4MDAsIEx1IEJhb2x1IHdyb3RlOg0KPiA+PiArDQo+ID4+ICsJaWYgKGxpc3RfZW1wdHkoJmlv
bW11X21tLT5zdmFfZG9tYWlucykpIHsNCj4gPj4gKwkJc2NvcGVkX2d1YXJkKHNwaW5sb2NrX2ly
cXNhdmUsICZpb21tdV9tbXNfbG9jaykgew0KPiA+PiArCQkJbGlzdF9kZWwoJmlvbW11X21tLT5t
bV9saXN0X2VsbSk7DQo+ID4+ICsJCQlpZiAobGlzdF9lbXB0eSgmaW9tbXVfc3ZhX21tcykpDQo+
ID4+ICsJCQkJc3RhdGljX2JyYW5jaF9kaXNhYmxlKCZpb21tdV9zdmFfcHJlc2VudCk7DQo+ID4+
ICsJCX0NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gICAJbXV0ZXhfdW5sb2NrKCZpb21tdV9zdmFf
bG9jayk7DQo+ID4+ICAgCWtmcmVlKGhhbmRsZSk7DQo+ID4+ICAgfQ0KPiA+DQo+ID4gVGhpcyBz
ZWVtcyBhbiBvZGQgY29kaW5nIHN0eWxlIGNob2ljZTsgd2h5IHRoZSBleHRyYSB1bm5lZWRlZA0K
PiA+IGluZGVudGF0aW9uPyBUaGF0IGlzLCB3aGF0J3Mgd3Jvbmcgd2l0aDoNCj4gPg0KPiA+IAlp
ZiAobGlzdF9lbXB0eSgpKSB7DQo+ID4gCQlndWFyZChzcGlubG9ja19pcnFzYXZlKSgmaW9tbXVf
bW1zX2xvY2spOw0KPiA+IAkJbGlzdF9kZWwoKTsNCj4gPiAJCWlmIChsaXN0X2VtcHR5KCkNCj4g
PiAJCQlzdGF0aWNfYnJhbmNoX2Rpc2FibGUoKTsNCj4gPiAJfQ0KPiANCj4gUGVyaGFwcyBJIG92
ZXJsb29rZWQgb3IgbWlzdW5kZXJzdG9vZCBzb21ldGhpbmcsIGJ1dCBteSB1bmRlcnN0YW5kaW5n
DQo+IGlzLA0KPiANCj4gVGhlIGxvY2sgb3JkZXIgaW4gdGhpcyBmdW5jdGlvbiBpczoNCj4gDQo+
IAltdXRleF9sb2NrKCZpb21tdV9zdmFfbG9jayk7DQo+IAlzcGluX2xvY2soJmlvbW11X21tc19s
b2NrKTsNCj4gCXNwaW5fdW5sb2NrKCZpb21tdV9tbXNfbG9jayk7DQo+IAltdXRleF91bmxvY2so
JmlvbW11X3N2YV9sb2NrKTsNCj4gDQo+IFdpdGggYWJvdmUgY2hhbmdlLCBpdCBpcyBjaGFuZ2Vk
IHRvOg0KPiANCj4gCW11dGV4X2xvY2soJmlvbW11X3N2YV9sb2NrKTsNCj4gCXNwaW5fbG9jaygm
aW9tbXVfbW1zX2xvY2spOw0KPiAJbXV0ZXhfdW5sb2NrKCZpb21tdV9zdmFfbG9jayk7DQo+IAlz
cGluX3VubG9jaygmaW9tbXVfbW1zX2xvY2spOw0KPiANCg0KZ3VhcmQoKSBmb2xsb3dzIHRoZSBz
Y29wZSBvZiB2YXJpYWJsZSBkZWNsYXJhdGlvbi4gQWN0dWFsbHkgYWJvdmUNCmlzIGEgcGVyZmVj
dCBtYXRjaCB0byB0aGUgZXhhbXBsZSBpbiBjbGVhbnVwLmg6DQoNCiogVGhlIGxpZmV0aW1lIG9m
IHRoZSBsb2NrIG9idGFpbmVkIGJ5IHRoZSBndWFyZCgpIGhlbHBlciBmb2xsb3dzIHRoZQ0KICog
c2NvcGUgb2YgYXV0b21hdGljIHZhcmlhYmxlIGRlY2xhcmF0aW9uLiBUYWtlIHRoZSBmb2xsb3dp
bmcgZXhhbXBsZTo6DQogKg0KICogICAgICBmdW5jKC4uLikNCiAqICAgICAgew0KICogICAgICAg
ICAgICAgIGlmICguLi4pIHsNCiAqICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICogICAgICAg
ICAgICAgICAgICAgICAgZ3VhcmQocGNpX2RldikoZGV2KTsgLy8gcGNpX2Rldl9sb2NrKCkgaW52
b2tlZCBoZXJlDQogKiAgICAgICAgICAgICAgICAgICAgICAuLi4NCiAqICAgICAgICAgICAgICB9
IC8vIDwtIGltcGxpZWQgcGNpX2Rldl91bmxvY2soKSB0cmlnZ2VyZWQgaGVyZQ0KICogICAgICB9
DQogKg0KICogT2JzZXJ2ZSB0aGUgbG9jayBpcyBoZWxkIGZvciB0aGUgcmVtYWluZGVyIG9mIHRo
ZSAiaWYgKCkiIGJsb2NrIG5vdA0KICogdGhlIHJlbWFpbmRlciBvZiAiZnVuYygpIi4NCg==

