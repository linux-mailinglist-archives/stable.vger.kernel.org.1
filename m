Return-Path: <stable+bounces-119741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96453A46B2E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED4F3AF81C
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB423F421;
	Wed, 26 Feb 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kh//LR79"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A123A9AF
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598530; cv=fail; b=Z8fJXdGbBzYXSFdlTwRZBl4YkNzGvdlT03VNfHLflYBQFD8k8aXNqXYky3zhDTCKpNVL46tCgZuL+Zm/vUFS1HshXYs/44/kswivzjkrU25dYe1s1VHUCVuzXp330homzW/X3/y4vfNQxEjTzQVEQbvmKIcYTUFVgq/K61s3Kq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598530; c=relaxed/simple;
	bh=DW2tbuj6sx2MN1ori8f3yJCjKyGJQRY+doCqiWxhxU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpCFfnCGevNiCsQ0YtfHx9nYnLYOrV0Lv4WhS8QzFJKYQ8fQfr78hI+nNMVBziPj/+wVyEotTuMIH3w5hWb7ZQrjzmlmQz/RFduwQB9ALpnpYgln35WIu6puoTxKBcUavaB/hntyCRFVkui2fTwibZvdGXWB/VwTwDzupc+NMnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kh//LR79; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740598528; x=1772134528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DW2tbuj6sx2MN1ori8f3yJCjKyGJQRY+doCqiWxhxU0=;
  b=kh//LR790Lv240tLF8206JCNykSAYdejh0N8Yks7rtkwbS+NMTI+s2VA
   0lbghxutO8KFlcJ/Oodqh7g2JwyKs/tSOH7MqQXhZobe1e45WOn2x9dlf
   /AGFZpMK0f7NrLCwNVz+A3S6XA/M+144mmUZLCAN6JhViBxcuYaQ+vIdi
   /CWraIorvQ1GsQG0aDQEDAsn36/DlSxFq3h12jpi66nG1WJyp2BA2v0os
   fnH9mQ1rnYakgbLCub5ENB+sPGTvW/IzlypdgNZg9ALmIL8jKQUpmc260
   SNMXIMjKrmBtH+WzKagnIh7XP+eienie+kld3coDhWZIKQDn50Cogztfr
   A==;
X-CSE-ConnectionGUID: qC6J+PLjQC+g1tRF8pRPGA==
X-CSE-MsgGUID: ro+thP70StuZMqNx/TW6CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41314731"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41314731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:35:28 -0800
X-CSE-ConnectionGUID: y6yOqdgMQlqA8oF8PTTIxw==
X-CSE-MsgGUID: SyPctzy2Sf6QhcE/juLjxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="147623339"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:35:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 11:35:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 11:35:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 11:35:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqbm18ljs+GEjXzjiNF/JPMGspncDtv1nuzpS/7h8xQJnmsbmroxeFOFoVOPXhYl+HNyh4XnAxv58MmZf2H7Ec9fIuwZl42vxgJkAfDNRi3yXnEeDY0k+SxSxpdvHmX/zn1g92i6B6T8DscJbY2W5QzjYV7d0VAGKeNJTXebU9CtDNRVw1YsyZWOTGPhmxN0yq1F1LiPrJHx1xI+GY2HWeU8OhjO0wDnJ46omkrONMLBy7zHKqVS4sx9mF74DNmU2dsmSoTB0Xf8DNUWGENPurf21nRaL2i4MEnIUDYuxf0IITl9eWOH7dZ49jLbeAy88+JkCsJL63S3IkUexACcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2tbuj6sx2MN1ori8f3yJCjKyGJQRY+doCqiWxhxU0=;
 b=py/KLOMVTeL88scq4S7KnGZvc5E2Sdl6dM2UOuaerOi2ZxqfjQyuNeucpaQKx/YnSlv+EEk9RzI+L8DQRJURep+4Ta71VTPEmhQMYHVY78FKkpzECl7DHxGTDy5e/VEEqaR9IkAAMF2sQkiim13gfXO5ldp2C9InTk/CZrDcWugifulApH2fZcLQLv9yq3Qqw8qvchIha+gxxgAPVYfnT5AIqb+ss6q0TU4OPd0EA3RNaXW7d0QMgIqYpiicZW7wS1Nw1nwYpSmpdXl+xScD2KWMnepUjEYoP8Msqc6XX5R2ropjTuZApzddS9G2QAY0Azh5boMlr+RFiiSicKglMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) by
 SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 19:34:59 +0000
Received: from DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c]) by DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:34:59 +0000
From: "Hellstrom, Thomas" <thomas.hellstrom@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld,
 Matthew" <matthew.auld@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Topic: [PATCH v2] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Index: AQHbiHarFOlaDW00U0SnkIqj4LPhL7NZ+huA
Date: Wed, 26 Feb 2025 19:34:59 +0000
Message-ID: <597b3cc1928493edcb6538f5f56bf67d0c7894ea.camel@intel.com>
References: <20250226174748.294285-2-matthew.auld@intel.com>
In-Reply-To: <20250226174748.294285-2-matthew.auld@intel.com>
Accept-Language: en-SE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7733:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: e2d2f742-1ab9-4d61-feff-08dd569ca85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnRQR3JlZ0tMc1hDTmRDdUN5SXozWmdacHZXOGEwV1BzZ0Z0RlFDOUkrN0pD?=
 =?utf-8?B?Q3gwUTM5eThGOEFmTVhJajZSbmk2MWpPY2ZuZFdhaTAzVlI1Z1dCM3NnT0xQ?=
 =?utf-8?B?Q21QK3JoRkEraEtoZ3E1NHg2VWZ0aTVyQlNLRkluMzJReG9sb1BldE5mTzA4?=
 =?utf-8?B?c3NhZDFYTlZXeTFzTUZmejBFZDhKMkxZNURndlVmNGdLcWg1UmVnVTRKNmU3?=
 =?utf-8?B?NW05ZnJCb1RaZXk0YnNDWEVBZEwzWnMxTEFRRk4wZXB5emU4a3MrdjVCRmlR?=
 =?utf-8?B?Vy8wTHRTSURmZ1hvaGNWaFJ5d0F1dDFjY0t2WGx0SmkvTTRMM2hrcm00VVlx?=
 =?utf-8?B?ZUMrUEpQZ0NlZklWNTZVZGtwMm4vTjVveGdaaTZBaXIyYXl2NVJVUGduWlVk?=
 =?utf-8?B?bDdFQzV2Y0dTR3BGRVprd09vTzU0QWsrTExWbjhESXJOZUp1Z2Jpb0VZZVNT?=
 =?utf-8?B?NDVHcE5RT1BWL0ZBZlpScVJyRzI4SDU0bERWNDVvWWRWcm9RMUczbnd1cm5D?=
 =?utf-8?B?SUJsKzdHeFBndVBPSWVHUFFxc2x3MTlrRDVMMnVMUVdaT3g5VEdmVmNZcVd6?=
 =?utf-8?B?MXpmWW80SER4RTFvTzlDdFY1M0o5eXpKbmczVXFpMC85dGJaY283b0hKWWlj?=
 =?utf-8?B?K0Jlc1J6dngyOHB4UjYzQWNCMlVudU13cTE1aHVRa0Rtb2pSQzB3N3A5S0ZU?=
 =?utf-8?B?VEZoN1dpUGRtMXZwMmU2WDR3ZC9jNFR2cnpkMXZsdEdiVERaR2lEd21sK0Vm?=
 =?utf-8?B?N01EQ2hSNUN6b2ZKMmsrU3NNOTBNUXFYRTNWQThQZTgwMllGQ3hoTDdDb0l6?=
 =?utf-8?B?S2R4d1RmeUFkNGlydG85d1BuaENLRUVrK1o5N1dNZkdCZEhPVEJwUStKaW9v?=
 =?utf-8?B?b0JYZWJ4QmFwUVBsTVVPbE1UYnVjUENZODVGMnZEbCtDclo0SjdxczY2UmRi?=
 =?utf-8?B?bUEvWnR3S1pQWEwzSjlhWW5qWHNBaEYySFdJK1F4ek1tdjQxbkFLdFpGUDdY?=
 =?utf-8?B?TU9qVEc4Q0pXT08wZ2xqdXU2OWZsRjhzeklzTkQvMCtlTGJUZ0psTWZvQS9C?=
 =?utf-8?B?UnpvTmY3QlRTMzV3aUF0NWhMeHRpRGlYR1phNVFNb0NmRnZ1TUphVUFlUDk5?=
 =?utf-8?B?VE5PQzVRd1Z1UWY2RHk1cEpBNXc0RlhPUUY5Qk5DRmVEbTNPaW44WnFHYmNP?=
 =?utf-8?B?dmhBekxSdHFvZkxzSDkvbzZGSS9lVVVjUk1yQkhSeGorcVU0SlV1YW9KRFZu?=
 =?utf-8?B?dXQyNEpIcm9xKzhDOXVaemQvWTlzK3IyNk9GcUhTdXV4SjJWTHJaQmE5ZjJ0?=
 =?utf-8?B?UFhCNEtlVSsyU0NsSDZSMUl3WDJSUVZBTmRDdzBPWkwzblE3RW1UMW8zYUl0?=
 =?utf-8?B?TUYvdnpHc3lBMDFEckh0ckhoY0k3a0tyUFhZN2ZrbmhJWUIreERSeGttUVhW?=
 =?utf-8?B?bGNDVDgvaEZMZENZdFo0ampLQ3h5dFFWSVM5TlNZUXFMc2twSVpRaDBVQ3N6?=
 =?utf-8?B?dElUL1U1WUY2KzBtMVRFbExtSkpzVDlYRUw3VlhTTU15dStKMDhhMGd1S0FR?=
 =?utf-8?B?aXR6OW1GYU51STVtMXNzNlRPZ2Q4blZKTEt5MTZ3UGVNMXhSb1RwSUtZWEt4?=
 =?utf-8?B?K0RDM2pDcGhudjBPT2M1bHZBcEdHU3BiQkJ3OVY4TlJ2bEROL3laekpVNXdL?=
 =?utf-8?B?K0ZEb2Q2VnVpTDcwS0laWCtyK2N6alJGYnNPSjFQdEFWL0Q1a2ZNMGFCTEJL?=
 =?utf-8?B?anhiVnBPS1ViWGFleWJSZ2liSVdyL2UzUUluODM0bnBUR3dlS01CTUI4aTBU?=
 =?utf-8?B?VzZkUjM3MDl4MktXMEptOTlJNHZySkxKOEt4S3ptdzVzU0M2aWlHU29zMTFY?=
 =?utf-8?B?azlVMXN3V2IvNTd2RFhPZDdlU1dxeHNUOTRsR0RZMnJ6d1NocUJ5cXdMcmtj?=
 =?utf-8?Q?UaWzapepRMyDfVpNjoY3tLTQkLrAIGj7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJZWGpkL3F2UExpZTlHRjMzamNSYURpOFZVSEd1TFdJWWRMSnh5SDZiZ2xW?=
 =?utf-8?B?c3FEOTFSdkM5cmVXMTNQV3FuQ0NCckNJVWlRSGRxV0V6bHBFVkJsMExlUWI4?=
 =?utf-8?B?MUZvbWZIR3lVenV3OFpDU0c5RElsb3ZlV2RBeE8wSnRlN0xvQk5mb1dyTzk5?=
 =?utf-8?B?Y1J1UjZzNFlaTWpwL1l3TktzdWFPSGEzK2FBY1lkZDRPRGU3SXQweW1hVG03?=
 =?utf-8?B?QndDSmswenVCQVRmNXVKMWdhMUF5ck1TTDNDVmkzUmt5V1V4OEU2bElGak8z?=
 =?utf-8?B?cndVUzByNVBKN1B1V2xlZFVjRituL1Z6VUo1SVZQZDJjdUFxUGtpU3UwVFRE?=
 =?utf-8?B?Y0ZkMkR1K1gyTm9OSmpSRmR1ZE41K2ljUUZ6dE54RE5FVFB3WXFDNGdYUy9w?=
 =?utf-8?B?YkIxNlpldkM3QVFGMEVHQ3NOMXJqbFpDbkdUSkh0NE9rSVZzdWFidCtTRHlU?=
 =?utf-8?B?cTZqRXp2ZVJhWHVTSVh3RTFrQlYvZ0pTNlVWckFxaUZCcUxuRzF2YWxuZFF2?=
 =?utf-8?B?VVJqYUNZNUVFY1pxdkR0R0E3TWhaY2JwWC9hWUZQUGx2TzVEejFJV2wrQmRJ?=
 =?utf-8?B?QWFSK21jRmIxRDlYSHJ0Qm0zcTIxS09ObzBJTVpjWkN1REF2S3hiZ3lTRXds?=
 =?utf-8?B?ejRoVDErcjhOclFMRTMvYVJ0cnA5d3RkazlwQU9GcDUyeXZxMFA2OFF1NEow?=
 =?utf-8?B?R0p5YWpVQzNxWk9sUDNYWGt6cVNPWFl3bW83bzVNbXlJejJrL2ZlSy9KWTFV?=
 =?utf-8?B?cUUzODhBSGpUMTdxZWQ5dkFpckNxVWlRdFFCYnIyR1hBVFlNekVSVGNaOFk1?=
 =?utf-8?B?dks3SFRjK0NGUWZJUHU5REdRbnJ5T3V0K0NsdEQyYnBvWGlBRXI5Zi9BT0N0?=
 =?utf-8?B?d3J3RmIwaFVPajVrc3dHM1prUWlLNzlueUJ4Z1JWV3hFdzZDWStiMWc0OVpv?=
 =?utf-8?B?SlhYQWpDWUluTU9oZThjQWtqS0Qxd0ppUElPZzVBNXcxcUFYTDFyUUZUSTgx?=
 =?utf-8?B?YXo5U2NIdmlKTmZKSTVtN05pa1VBOXJOTDJoRTFCOERaVWEwM1djWlFxT0Nt?=
 =?utf-8?B?NzV1Yit6clE4M2ZSNHNFRndUOUYyM1RDc3dud2ZKbEhieHhQY2VuR1NKWXl6?=
 =?utf-8?B?OGZzZGUvdkY5RnA1Q1dWeUwrU2VXQzF4bTFtN0kzc0JmbFg1RkZRV1VPUWp0?=
 =?utf-8?B?NHlabmh3aWduR2lyYmJRbFowY3BzRUd2aWt5Q3QrR3NNQ005YXdyMDRvSDhI?=
 =?utf-8?B?dWV3UUxMWFJIWXRzN1JWdThHd2svZTluSXZUaWg5UmxIWUczd1VONG9kOGYy?=
 =?utf-8?B?bExVVit5R3lOb0liT3dad29JbENvd1QxQ3lXMHNRbFZIb20xbGowRVBMajRY?=
 =?utf-8?B?TWJlYmZyWXVDVXQ5Ui8vdXRMQjdqcmNDdFVFZFcwTGl1L2ZkTzV1dWE1ZlJ3?=
 =?utf-8?B?N2NQVHVid3NXbnVnRytZbUM4akVjK0JrWUExRmp1b1RmRGdVOHZEZGNMMW1C?=
 =?utf-8?B?aFA3QzNyNk9GT1VybXVrOE0rT1V2UW1pL0I3WEVkbzNTVHpKN1NEODRPN3Nj?=
 =?utf-8?B?SkovbjFHdmRjK2lVTmlYVm9ZWGwzdDl5Yk5XZU0rN1B6azMxcXdUZzF2dklW?=
 =?utf-8?B?eCtVRE5ZSSt2V2FNdUNEYmc4SDAzc29rdjhyUkdTdzREVHIwWW1lbGkxcUVM?=
 =?utf-8?B?WTRzSW9HWXk0V3pPU2pXS0ZoRzd3R2VpcWM3SkRrOUlxZmZxOXY4UlBjN2FL?=
 =?utf-8?B?RnlsOENqQStNdXZDWXFDdG5ZVTc5MDQxL2lVVjY1emVHN040cFJOMmJteWNC?=
 =?utf-8?B?WDEvYUM5cWt1L1R5eEVETnFTM25xRm5mTllkeFpzSFVqM3pDWEZoR2pPQTRr?=
 =?utf-8?B?VXpkdStOVCs0WlVOaFROVG9BWGNVSkJGc21venMydVNUNFUyd1BpZ3EwcFFP?=
 =?utf-8?B?aFVhVWY5RnVGdUUxSGtiN0pyeTN5UU9qK0ZCQWZYSll5TXVhbnFEU0Eyb3VL?=
 =?utf-8?B?Um5YenkycVpkeWFJQUpuYXFCRW5Vazhwb1Q3OGVIcDJQNVdNTTYxcVc1T1hV?=
 =?utf-8?B?L3dJMkI0Vng5eW81SkZtRHljZXB0RXhlbFc1ZnpMUnEyUkpvNHpyWE0yTzQv?=
 =?utf-8?B?UXpJMmhlZHlXOEYwZkxZTXVVT3Q1ZHdsVVBTNHROdnRnUlI4VFJDbkxkWDFu?=
 =?utf-8?Q?xN3xcX7BU8X1ZrNsgkDmW67nyDNQWukM04blw3rEEs2e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D508401F46E440ADAFAC266BF09E42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d2f742-1ab9-4d61-feff-08dd569ca85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 19:34:59.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enxGrkLIVRUfnY9xB807gz/jLI9VH7M6mpuUeFWyrwZjldz1Qb4A0o2HRLUygAI4WDFR8bbuq7d+l0A3uNahMvT1MhSaMQ7RdOkH8Hf2Ocw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDE3OjQ3ICswMDAwLCBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+
IEN1cnJlbnRseSB3ZSBqdXN0IGxlYXZlIGl0IHVuaW5pdGlhbGlzZWQsIHdoaWNoIGF0IGZpcnN0
IGxvb2tzDQo+IGhhcm1sZXNzLA0KPiBob3dldmVyIHdlIGFsc28gZG9uJ3QgemVybyBvdXQgdGhl
IHBmbiBhcnJheSwgYW5kIHdpdGggcGZuX2ZsYWdzX21hc2sNCj4gdGhlIGlkZWEgaXMgdG8gYmUg
YWJsZSBzZXQgaW5kaXZpZHVhbCBmbGFncyBmb3IgYSBnaXZlbiByYW5nZSBvZiBwZm4NCj4gb3IN
Cj4gY29tcGxldGVseSBpZ25vcmUgdGhlbSwgb3V0c2lkZSBvZiBkZWZhdWx0X2ZsYWdzLiBTbyBo
ZXJlIHdlIGVuZCB1cA0KPiB3aXRoDQo+IHBmbltpXSAmIHBmbl9mbGFnc19tYXNrLCBhbmQgaWYg
Ym90aCBhcmUgdW5pbml0aWFsaXNlZCB3ZSBtaWdodCBnZXQNCj4gYmFjaw0KPiBhbiB1bmV4cGVj
dGVkIGZsYWdzIHZhbHVlLCBsaWtlIGFza2luZyBmb3IgcmVhZCBvbmx5IHdpdGgNCj4gZGVmYXVs
dF9mbGFncywNCj4gYnV0IGdldHRpbmcgYmFjayB3cml0ZSBvbiB0b3AsIGxlYWRpbmcgdG8gcG90
ZW50aWFsbHkgYm9ndXMNCj4gYmVoYXZpb3VyLg0KPiANCj4gVG8gZml4IHRoaXMgZW5zdXJlIHdl
IHplcm8gdGhlIHBmbl9mbGFnc19tYXNrLCBzdWNoIHRoYXQgaG1tIG9ubHkNCj4gY29uc2lkZXJz
IHRoZSBkZWZhdWx0X2ZsYWdzIGFuZCBub3QgYWxzbyB0aGUgaW5pdGlhbCBwZm5baV0gdmFsdWUu
DQo+IA0KPiB2MiAoVGhvbWFzKToNCj4gwqAtIFByZWZlciBwcm9wZXIgaW5pdGlhbGl6ZXIuDQo+
IA0KPiBGaXhlczogODFlMDU4YTNlN2ZkICgiZHJtL3hlOiBJbnRyb2R1Y2UgaGVscGVyIHRvIHBv
cHVsYXRlIHVzZXJwdHIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcu
YXVsZEBpbnRlbC5jb20+DQo+IENjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVs
LmNvbT4NCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGludGVsLmNv
bT4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjEwKw0KPiAtLS0NCj4gwqBk
cml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMgfCAxOCArKysrKysrKysrLS0tLS0tLS0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0veGUveGVfaG1tLmMNCj4gaW5kZXggMDg5ODM0NDY3ODgwLi4yZTRhZTYxNTY3ZDggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9obW0uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0veGUveGVfaG1tLmMNCj4gQEAgLTE2NiwxMyArMTY2LDIwIEBAIGludCB4ZV9obW1fdXNl
cnB0cl9wb3B1bGF0ZV9yYW5nZShzdHJ1Y3QNCj4geGVfdXNlcnB0cl92bWEgKnV2bWEsDQo+IMKg
ew0KPiDCoAl1bnNpZ25lZCBsb25nIHRpbWVvdXQgPQ0KPiDCoAkJamlmZmllcyArDQo+IG1zZWNz
X3RvX2ppZmZpZXMoSE1NX1JBTkdFX0RFRkFVTFRfVElNRU9VVCk7DQo+IC0JdW5zaWduZWQgbG9u
ZyAqcGZucywgZmxhZ3MgPSBITU1fUEZOX1JFUV9GQVVMVDsNCj4gKwl1bnNpZ25lZCBsb25nICpw
Zm5zOw0KPiDCoAlzdHJ1Y3QgeGVfdXNlcnB0ciAqdXNlcnB0cjsNCj4gwqAJc3RydWN0IHhlX3Zt
YSAqdm1hID0gJnV2bWEtPnZtYTsNCj4gwqAJdTY0IHVzZXJwdHJfc3RhcnQgPSB4ZV92bWFfdXNl
cnB0cih2bWEpOw0KPiDCoAl1NjQgdXNlcnB0cl9lbmQgPSB1c2VycHRyX3N0YXJ0ICsgeGVfdm1h
X3NpemUodm1hKTsNCj4gwqAJc3RydWN0IHhlX3ZtICp2bSA9IHhlX3ZtYV92bSh2bWEpOw0KPiAt
CXN0cnVjdCBobW1fcmFuZ2UgaG1tX3JhbmdlOw0KPiArCXN0cnVjdCBobW1fcmFuZ2UgaG1tX3Jh
bmdlID0gew0KPiArCQkucGZuX2ZsYWdzX21hc2sgPSAwLCAvKiBpZ25vcmUgcGZucyAqLw0KPiAr
CQkuZGVmYXVsdF9mbGFncyA9IEhNTV9QRk5fUkVRX0ZBVUxULA0KPiArCQkuc3RhcnQgPSB1c2Vy
cHRyX3N0YXJ0LA0KPiArCQkuZW5kID0gdXNlcnB0cl9lbmQsDQo+ICsJCS5ub3RpZmllciA9ICZ1
dm1hLT51c2VycHRyLm5vdGlmaWVyLA0KPiArCQkuZGV2X3ByaXZhdGVfb3duZXIgPSB2bS0+eGUs
DQo+ICsJfTsNCj4gwqAJYm9vbCB3cml0ZSA9ICF4ZV92bWFfcmVhZF9vbmx5KHZtYSk7DQo+IMKg
CXVuc2lnbmVkIGxvbmcgbm90aWZpZXJfc2VxOw0KPiDCoAl1NjQgbnBhZ2VzOw0KPiBAQCAtMTk5
LDE5ICsyMDYsMTQgQEAgaW50IHhlX2htbV91c2VycHRyX3BvcHVsYXRlX3JhbmdlKHN0cnVjdA0K
PiB4ZV91c2VycHRyX3ZtYSAqdXZtYSwNCj4gwqAJCXJldHVybiAtRU5PTUVNOw0KPiDCoA0KPiDC
oAlpZiAod3JpdGUpDQo+IC0JCWZsYWdzIHw9IEhNTV9QRk5fUkVRX1dSSVRFOw0KPiArCQlobW1f
cmFuZ2UuZGVmYXVsdF9mbGFncyB8PSBITU1fUEZOX1JFUV9XUklURTsNCj4gwqANCj4gwqAJaWYg
KCFtbWdldF9ub3RfemVybyh1c2VycHRyLT5ub3RpZmllci5tbSkpIHsNCj4gwqAJCXJldCA9IC1F
RkFVTFQ7DQo+IMKgCQlnb3RvIGZyZWVfcGZuczsNCj4gwqAJfQ0KPiDCoA0KPiAtCWhtbV9yYW5n
ZS5kZWZhdWx0X2ZsYWdzID0gZmxhZ3M7DQo+IMKgCWhtbV9yYW5nZS5obW1fcGZucyA9IHBmbnM7
DQo+IC0JaG1tX3JhbmdlLm5vdGlmaWVyID0gJnVzZXJwdHItPm5vdGlmaWVyOw0KPiAtCWhtbV9y
YW5nZS5zdGFydCA9IHVzZXJwdHJfc3RhcnQ7DQo+IC0JaG1tX3JhbmdlLmVuZCA9IHVzZXJwdHJf
ZW5kOw0KPiAtCWhtbV9yYW5nZS5kZXZfcHJpdmF0ZV9vd25lciA9IHZtLT54ZTsNCj4gwqANCj4g
wqAJd2hpbGUgKHRydWUpIHsNCj4gwqAJCWhtbV9yYW5nZS5ub3RpZmllcl9zZXEgPQ0KPiBtbXVf
aW50ZXJ2YWxfcmVhZF9iZWdpbigmdXNlcnB0ci0+bm90aWZpZXIpOw0KDQpSZXZpZXdlZC1ieTog
VGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KDQoN
Cg==

