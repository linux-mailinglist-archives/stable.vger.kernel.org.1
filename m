Return-Path: <stable+bounces-115066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58FDA32B17
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7616339F
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955F210F59;
	Wed, 12 Feb 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ+DCn8t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF91D89E4;
	Wed, 12 Feb 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376267; cv=fail; b=GhXOlRO8/d5jWD7Bt7PVfKIDisXCWDDrvu8cbjkC8IMRvrtB37TFv5QO/wfXYc2vA9Nwu+GP/Yu7TpMdK8uqTKv/BkwaIkLFJMt42GaY+T8FEYDtR5sBPISmgd+dfVH79DhFu36v2dpD40Ud7GpIcxYeieDH8fZjEZMj3VuhUOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376267; c=relaxed/simple;
	bh=mxCKQpuf6iOyOCaIHcxx6XR3Inu4lYo1Y5mTM0KqkTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VSG98ewS9+JX854koKH7NLNDdO1sO2XzMeqUWnFnM/JtQQWlHdEjOG1N7BQ7NsCcBo2MbYPAOYMi+Zk7t6snUpPY0kGli9ePhs1Il0F28JI2CLWa21jWQ52lAPVwtLvMqUMQlt8Oz6mp1+qei87VQiGy/AF0RxmyaMZ4pP+fswQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ+DCn8t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739376266; x=1770912266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mxCKQpuf6iOyOCaIHcxx6XR3Inu4lYo1Y5mTM0KqkTM=;
  b=iJ+DCn8t7e9UnisjP7TmUzI+hoAVQJJazxCtFeZnPzPRn6nKGqfiOlvT
   B2qVf7/GUo36uSvU2OPuCYZeY1y/1JA/mKG/x8/ZeC2FiGDyJZD/gAEqk
   NBP4wrOu8wvyIvY8r/8Pkhz/3gbq7ycLs7DMUwIYmJgzTv8v6dD+g2suQ
   QOLDj+TMzuYpzK/3MtCvUtCL2DcT91ElcleogG43qhLwnhufZkKf3LjkS
   HGzGyxHcl5ChiQTYenL8LsFp5S0MGVb9uNKB7Wu9xXtP094T6swF0fViF
   YGklkwU9OTnB1412JpEN1YSX342Sn6JGh2sHXmn6sid3tnTlJ9baDMPxe
   g==;
X-CSE-ConnectionGUID: AO4WylZwRnmuBhT9F4TDvw==
X-CSE-MsgGUID: ZcEWjMV7SFmoJ60mf/vMgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40073999"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="40073999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:04:25 -0800
X-CSE-ConnectionGUID: ftra6XgOQsiZsQZDW9HSvQ==
X-CSE-MsgGUID: COCqlF1zSKCJjyBDmW9PCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112824384"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 08:04:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 08:04:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 08:04:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 08:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9EHVSBtAUoOALOG76CLnM9S59vKopjlafErDm4lgxG8OCwPrpVsN2vOlcvInsFPcc1zOMeOUA3XBbDtEgSrTq8WEi9nCf84J/eGr2CnFH948y+7bK1UZDjn/J+1aVlGfm2uqD4tYEvHmXzmveob9MO/IgSftzDUPSqig1twhLWvrmxzusROPkDk58yOGjj6VmLQlDOXVHUbhIksWYk5STt9zKuZdyaS+InTP+XGZv2kesphFeBoqdSZHEvHzm61RjCgwKRdRp8dbucPhcR4r78UmPKRdItsN8FmXmjYUDTNU4zH3ZevhH/BZKv2oRhr2292e85DBl+OmqVnKbrocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxCKQpuf6iOyOCaIHcxx6XR3Inu4lYo1Y5mTM0KqkTM=;
 b=v6esBVf4tP+BJw1a6BwNjdxLkpZLvsbBbdOzjUsYiX8w08yqL5qM1+LKkquFRennHt+najh3jgPpe8fEln+IedAd+/Q3OnuVZGTVcKf2ngXDCOrtp+iWHlf0ZzxgrLtXDPDoc4kEQqOWFEcNqyiT5xf8NyMU7ZgJ98JcWO6vkbAY5p9K4NDjSjwgOAtBrM8CQMsTHy9PMXDY/ocuetB1Cloe9AHP+pMBh1VqUnnvEyIqIYvQkc8K+NITt2slJlszwA8md89zjOCRI0H6d9XhLLRQjwbPKFqU+B6O5rzNECIuV6ESzde59rVYF8cKC7Wydun60aXiHrMRy5LpK37Iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 16:03:54 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 16:03:53 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "nirav.rabara@altera.com"
	<nirav.rabara@altera.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: socfpga: agilex5: fix gpio0 address
Thread-Topic: [PATCH] arm64: dts: socfpga: agilex5: fix gpio0 address
Thread-Index: AQHbfTWkrINtkaMRwE2kVpjSoyZl9rNDzBCAgAAF/iA=
Date: Wed, 12 Feb 2025 16:03:53 +0000
Message-ID: <BL3PR11MB653289A0BDF5573776D2E519A2FC2@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250212100131.2668403-1-niravkumar.l.rabara@intel.com>
 <162eef45-3740-4197-adf4-8f20850b332c@kernel.org>
In-Reply-To: <162eef45-3740-4197-adf4-8f20850b332c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|MN2PR11MB4598:EE_
x-ms-office365-filtering-correlation-id: ce4808ba-e663-494a-a948-08dd4b7ed937
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cEVKRFF2MisxcUZOdTRBWlcxMC9VUEIydG54NmtwTk5HT08wOTU4TnZGVnNW?=
 =?utf-8?B?MllzblNyOHo5b0pYVHJCK0NMRnByNVNOME1OcVFJakxRcFlGNjl3Q3RmQk1n?=
 =?utf-8?B?VUkwNE5KV09mdW9LSEJUQnhTc2RPQy9wVVZkQzJEU1lPNXJOTnAxWUdKZkR1?=
 =?utf-8?B?cWY4b0s4WWRRaEJHTCt1NHFnQmdqS2hOSklib2U2OVFXVGF1emlDOUg0SS8z?=
 =?utf-8?B?U0dveDZ1V0VTOFhLbjFua3IyYjQ1NWp0YlM3ZTlFRHNWWlp3VW5qMUtFSUJr?=
 =?utf-8?B?YUdGWGh5cm9sckFNZDhuWFYyK0tQeGhrZUkyZXFhSG9odk81WTU3Z1hidktt?=
 =?utf-8?B?SFBRNFozMTZoSTRTNHQ5c3Y0MjVpZmVIanp3a3dvR1lRVXRIc282S21GdUZG?=
 =?utf-8?B?elN0Yk9oNjJuRVNvMVlJcGVKbm9SZFFqckgwRVc0cmFrN0o3dTFHQVJsajBh?=
 =?utf-8?B?V04yVDdEMFpqcFY1Z0dLajVZY1F3MzA1SnZiYjVtYjhHS1I3V0VrQVh5ZHdy?=
 =?utf-8?B?RWhRcVpkQk92Uml5NVVBTTMwYThyMHF5eWtWaGRIVHQxNVRLQ1FPUVdhUzlZ?=
 =?utf-8?B?R2RjaFhFVnBSRk5KdXBNaWNYSjlYVjE3aUdSdXN6ZUpSMDNDYk9NQXpkUmxh?=
 =?utf-8?B?WlBpdngyWVJaSmhsLzJCaE5ONGtUdjZEcnR6REJycXNqQkxYaWZqZ1ZXODRj?=
 =?utf-8?B?dEw1MXFweHRYM01Gc3M0VnVkVFlNeWhQb2dLQ3JoUE90UFRXcndQRFpwRHR6?=
 =?utf-8?B?alRlV1RFRzFrK0ZoZWJyc0YwY3h5K0xlTVhtazZyVm1TYncraGZpK2VkZzZR?=
 =?utf-8?B?R3VKdTVra0VqaDlUWlhsZ2tjRUxuK1hkVjJodDlHWHFaVjNiOXNBdUhkR0Fl?=
 =?utf-8?B?aE9lb0V3ZFY3emowcU8wcU9JN0M3NXU2S0JNWkxpZUFxc094MS90cmRDUzNX?=
 =?utf-8?B?WTloOExBZm80NXF5eHlUK3VFblBrclVaTWNzSW9CUW9kdkY5Z1QzYmE2cWx5?=
 =?utf-8?B?OEpOSWJZaHpaUnhQSys2ejBpSlpIOTZTR3lJSiswcDNDOHlrbXBuR3VqaC83?=
 =?utf-8?B?VTdVZWJ3MXFOMVVud1Uvbm1XWUM2TG9qNWI0SnBEM2FONWQvUldVTmtKTmE3?=
 =?utf-8?B?N3dxeFJNazVFVG1TdGRCVU44b0dSRnpSVjdoRmhPVFVhWHZxd1VIRnRCMFpy?=
 =?utf-8?B?eHYyZ2pRQXZKVFBoem5Jd1F2V3h2dlNYYXFXQTBrd1ZtbUw2QW9nczF3OUkr?=
 =?utf-8?B?L3p0em1aMGFaMUlhWmwzQTdXY2hucVBCVVYwMlRIK2F5bGo4S1NYR3lKKzMx?=
 =?utf-8?B?Zy9KeFB3UFhHTzFOc0ZTZDllc3RuWmdmbGZMTnlvVGxYeDlKcXJzK20xSksz?=
 =?utf-8?B?RndEbXJ0emZrRDFEWkhWWVgzVUgrYURhQWdrZmdqMTdCc0VPM1dyUEV0NjNv?=
 =?utf-8?B?Z0VXVnQzQzN1TjlYTnphUmo2MGlzQ0dmVFg4MExieGJwYWFVb3pMaTdKcGlt?=
 =?utf-8?B?dUtsOHdkYWx2TlVBaVpmMGc0TnRhUW1HOTFwVmZCWVc3WEg4cmNSOWhZUTBS?=
 =?utf-8?B?aXIwcEgxNHRFTTlKTEMxZ2lHcmFqNmZ3YUtVTzJOYWtlSlJkaitGTWpESkI3?=
 =?utf-8?B?cVFFN0VaKzNFam81UlBLTlBpTmJRd0ovMnkvaHA0UzJlbGlqaVIvaW1NbVdX?=
 =?utf-8?B?Z2VGM3h5SXVpUzBZSk9NR05HRjArS1NDT3UwVW50V1Vsb0dXVnBrOXJzaS8w?=
 =?utf-8?B?aTFtc2F6Mllvd3owbEFjemh1TzY2SHdkVFRNUW9RTG1hMTJyeFE4eGxOSTV6?=
 =?utf-8?B?NTlibkxRbll5RlVhMFZZUG1rMDZUVVBwbStKbXpHOW5WYU1aU29SMFdrcG9Y?=
 =?utf-8?B?dUlqcTdoOFkrS1IwL2ZsYjNlUnlEdHU2ZncveEI0YTlIbHlmcWppcllhMHF4?=
 =?utf-8?Q?4nKCeJ1mBVDRRhjW2WdQipM6H/yFTWJU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlV5L1piOFdLZDF5cmJYR2JLMWZCRUFpMkdDOGdkTXZnUUI4ZTFrbzc2Rnl6?=
 =?utf-8?B?Z0NuSjQxZGQ2ZTAzOFpnb3E5ZzZSYjRZemZQV2dES2lBbHY3SkkyNVBZS3RJ?=
 =?utf-8?B?REZMQWduY0RvN3FlM0hDWGo3NElJUWM3RkwrN2ppUFZ0UnBTYTIxMFpwRlc2?=
 =?utf-8?B?YVFRa1pUcUJHcWxlRUtWT0dSejZrZlAxMjUyT3JkTlRsOXRqcmxWRWhKdDMv?=
 =?utf-8?B?QkJXNlJQNWhPcWlkZDYrYkVWNkk4MHBFOENBUUlFYW8zK0FCSFVlYTVPM1pk?=
 =?utf-8?B?bGIrcTYxTCtiY0ZoRzUxOXpDSERpTFFyeDJUN2tOYU9HQ2JGU1ZzQjZRa3hp?=
 =?utf-8?B?WHBoeXFlaDliQUlLR3hBR1d4VTh0c0JkR1FiUzZteHVQWitXMjBqdkhOZG5R?=
 =?utf-8?B?ZktCSXNyK1BoRmNWalFHN0ZTTjFtY01TNHdKcTlMN0RtdU1SOVJmUG1zMm8x?=
 =?utf-8?B?cDhYYlpSNVlwQ21EOWtjSkNJbHBxN0l0a3Bjc2o2L3VPeVdlRHJyeEc5MW1S?=
 =?utf-8?B?b3VyclFCeCt0MlZ5M0Vzak9NL1FLZklaeEFpS3lKb28zb296Ny95QThtaTZR?=
 =?utf-8?B?dEgxRk1YcXNTTDVYQ1dSeDJ3enNzWk9wTjVmU2pjdyt1ZzBabzJ2SE9BNGtZ?=
 =?utf-8?B?OXhaV1BSUnNybFN4TXBGY2M4b0ZzYTdjc3BhdkFiU01ya2ZJMHdCM0FrMm4z?=
 =?utf-8?B?QXlMeWZxVk9hUXpJUS9Gd1poZWxrY0lqdnhoeFlUSjhUMFUyRE5pTVI4MDdt?=
 =?utf-8?B?Y3FCUjVJSDQ4YzdzT1BpUlN2TmYwdVdzTmxQckRiaFB2bEJnSVJ5YUZScHkv?=
 =?utf-8?B?ejRYR3VvaDZSVXV0QUkrNnFMcEFwVGVDdjQ0amc0cFFGaEVWdVJ6TmpnV2h0?=
 =?utf-8?B?S3RhUkc1UDN5UVA2UkYwSFhxZUtzUkxqQkZQWkJGYVlQZENLcmxYaFNLOWJD?=
 =?utf-8?B?L3g4WWFmeUVXWWpMVkZRS21QNDhjcFFLWmZIa1dteCtUWUJ0dTF6dC83bjd5?=
 =?utf-8?B?U0IyNy9hOVRBTmU0RFFQQXFUejI2bGZkaitXbkFZcFZYVjN0SWVOT3hjVFJD?=
 =?utf-8?B?dHpiWWlFOHZ4bFdnMmpEdUlPRkhFZGlXUHBLYk5LaTVpVzJtb3dVcERRblpr?=
 =?utf-8?B?bStJZnBRd3BFaXdqcTd2VG1vU2hLb3R2T1dza3dPSENlMjVWSDRWcFpRNm1w?=
 =?utf-8?B?VUNqcDFPTTNEVEdYTUpsWkJ0RUJ4RUFuV3FFOGtyMGlOOE15cWdHZGFLUHVS?=
 =?utf-8?B?cCtyK1FGV1BQSjV1Ny94RW8wNHg5UGZWR0J4VkpSK0NLUTlXazV1bFA2ZlVw?=
 =?utf-8?B?RmM3aWY0b09pQk8yYm56ZWpPKyt5UElYWmJaMXNnMUQ1YlphaWJHMFBZRFJ2?=
 =?utf-8?B?Nk9HdVM1c3FzYWloaGI0MzlUK0wvOHpLS0p5VFVkYXUxMllxZ1pzNWNwTUVF?=
 =?utf-8?B?RmJiNXFMNGp5MmY0MEYyK0NHL2lFWnFtYkZrenNuVkFXTmFITWNGRytWL1p0?=
 =?utf-8?B?VmNtZHMzbHlRK2FZUDBFVURLbGltcDFwenZWUXlXQjYzWWd1ZmdHSXpraTNw?=
 =?utf-8?B?REc4ei9GcldFSDN6aU44WThaMjJHSHh5UzhtUVFHdzFueHpuSWQzVXVoR0ti?=
 =?utf-8?B?OUxxcmFEa3h1bnIvK013dlIzQVdrZ1NKNEpZZkVSTWM5eUF1OUV5SHVjVDZT?=
 =?utf-8?B?b3pETFdYOXBJUHhGZmIxYWVFSWZLQ0VjaEVqaUxPSy83OUlXcUpXVUJ0T2M5?=
 =?utf-8?B?dUY3NjNxSTF1R2p5T1ByU0JzVnhab1lxWE91WlJ6VUd3Mm15UjdqUE5USWhU?=
 =?utf-8?B?K0lqRTJyYUc3NXJ6L1gyMUNtK0txSmRRbFFQcnFYMmlVbUxHbDdaUkRVZElU?=
 =?utf-8?B?Wkg3QVcwYXJlUFdNM0RXUXRhVllXYjNWc3VlOG8yV2FnTlZ4b25SL0hGWXpL?=
 =?utf-8?B?cy83NmltWHE2MFQyZnhtTFFJbWF4dFJGODFLMWpubkNtLytWb2ZmQ3N5anhw?=
 =?utf-8?B?ZHpMRStkWUx3QmY2TTU1aVRpM2p6N2dtZG5aNmhWNkhVdFlCWE9YVStuTzJu?=
 =?utf-8?B?MnhCMmhLZSs3RlhRenc1NEpJMWhlVlF1RS9NQTlyM1RCRG9VR2FYVHpKL3RG?=
 =?utf-8?B?a2Q5SUpUKzBEY3NBbDBhZE1wNG16U2x4QmpQa0Y3QXB1M0x4U2o5TWxsQTlE?=
 =?utf-8?B?K1ozUkZibWRsTFoybmh1ZXY3Y3JTQWc1UzgzNzN4bDU0MFdtdVR1eHdYeGlt?=
 =?utf-8?B?OFpQdVhIQjZhRmpPZE0wL1owRDdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4808ba-e663-494a-a948-08dd4b7ed937
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 16:03:53.5819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vke3ALRzJ7wBnbl0h3+nrLlrYLfn2zBb1LL9mfuJ6HAt7eLos/lgPHJddnCemOEDsgO3jtUJynaiJCbzQn6q/vlh698jylE5PXHR6P1RmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDEyIEZlYnJ1YXJ5LCAy
MDI1IDExOjMyIFBNDQo+IFRvOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmlyYXZrdW1hci5sLnJh
YmFyYUBpbnRlbC5jb20+OyBEaW5oIE5ndXllbg0KPiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBu
aXJhdi5yYWJhcmFAYWx0ZXJhLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHNvY2ZwZ2E6IGFnaWxleDU6IGZp
eCBncGlvMCBhZGRyZXNzDQo+IA0KPiBPbiAxMi8wMi8yMDI1IDExOjAxLCBuaXJhdmt1bWFyLmwu
cmFiYXJhQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBOaXJhdmt1bWFyIEwgUmFiYXJhIDxu
aXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gPg0KPiA+IEZpeCBncGlvMCBjb250cm9s
bGVyIGFkZHJlc3MgZm9yIEFnaWxleDUuDQo+IA0KPiBIb3cgZG8geW91IGZpeCBpdCBleGFjdGx5
Pw0KDQpncGlvMCBhZGRyZXNzIGlzIGluY29ycmVjdCBoZXJlLiAgDQoweGZmYzAzMjAwIGFkZHJl
c3MgaXMgZm9yIEFnaWxleDcgbm90IGZvciBBZ2lsZXg1Lg0KMHgxMGMwMzIwMCBpcyBjb3JyZWN0
IGFkZHJlc3MgZm9yIEFnaWxleDUuIA0KIA0KSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3Nh
Z2UuDQoiRml4IGluY29ycmVjdCBncGlvMCBhZGRyZXNzIGZvciBBZ2lsZXg1Ii4gIA0KDQo+IA0K
PiA+DQo+ID4gRml4ZXM6IDNmN2M4NjllMTQzYSAoImFybTY0OiBkdHM6IHNvY2ZwZ2E6IGFnaWxl
eDU6IEFkZCBncGlvMCBub2RlIGFuZA0KPiA+IHNwaSBkbWEgaGFuZHNoYWtlIGlkIikNCj4gPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pcmF2a3VtYXIg
TCBSYWJhcmEgPG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NS5k
dHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NS5kdHNp
DQo+ID4gaW5kZXggNTFjNmUxOWU0MGI4Li45ZTRlZjI0YzgzMTggMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9pbnRlbC9zb2NmcGdhX2FnaWxleDUuZHRzaQ0KPiA+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4gPiBAQCAt
MjIyLDcgKzIyMiw3IEBAIGkzYzE6IGkzY0AxMGRhMTAwMCB7DQo+ID4gIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPg0KPiA+IC0JCWdwaW8wOiBncGlvQGZmYzAzMjAwIHsN
Cj4gPiArCQlncGlvMDogZ3Bpb0AxMGMwMzIwMCB7DQo+IA0KPiBJIHNlZSBub3cgd2FybmluZy4g
QXJlIHlvdSBzdXJlIHlvdSB0ZXN0ZWQgaXQgYWNjb3JkaW5nIHRvIG1haW50YWluZXItc29jLQ0K
PiBjbGVhbi1kdHMgcHJvZmlsZT8NCj4gDQoNCk15IGJhZCwgSSBoYXZlIHN1Ym1pdHRlZCBpbmNv
cnJlY3QgcGF0Y2guIA0KSXQgc3VwcG9zZXMgdG8gaGF2ZSB0aGVzZSBjaGFuZ2VzLCBJIHdpbGwg
dXBkYXRlIGluIHYyLiAgDQoNCi0gICAgICAgICAgICAgICBncGlvMDogZ3Bpb0BmZmMwMzIwMCB7
DQorICAgICAgICAgICAgICAgZ3BpbzA6IGdwaW9AMTBjMDMyMDAgew0KICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3LWFwYi1ncGlvIjsNCi0gICAgICAgICAgICAg
ICAgICAgICAgIHJlZyA9IDwweGZmYzAzMjAwIDB4MTAwPjsNCisgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDEwYzAzMjAwIDB4MTAwPjsNCg0KVGhhbmtzLA0KTmlyYXYNCg==

