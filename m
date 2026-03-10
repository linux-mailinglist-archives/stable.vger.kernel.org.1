Return-Path: <stable+bounces-224522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCjAHzBKsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:43:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE43255017
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C21630330EB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD945346E50;
	Tue, 10 Mar 2026 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzOQRQOP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB09296BC1;
	Tue, 10 Mar 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160949; cv=fail; b=dvJranPYa7VpSggs1rOXDEVigscIPcksZXB/F3dhZTSqTUPsyD35YO+nfP87YmFpQyk6s0j8JtuMRRF6Yg3OYgBnmv7QEgulCn0LceWUGQPkrH20aS/vvK39M+nFPNcSKmmAyO2+YnPpND+O4CF8wek6i9bkdIXUuuKFrfXMiJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160949; c=relaxed/simple;
	bh=o4f69oLHzPE5Pfy+2qGhTC7DgVnvLZsUexI2fP9exdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQ7ozOlE28av1MTMdsrvQcYFCfX4l2ZpeG36yQ6lwWyo5LHX/cSGYPzfoWJOPdGOrjHlrmZyrBtoywfkKXJBpCCDdzTIYgGb7VN0t0bTGpmVHRM0qvE9fM028tluKQzawChrcC63pit8liCoCFPkA/TwcQnlOfJWlNFQF62FgGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzOQRQOP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773160947; x=1804696947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o4f69oLHzPE5Pfy+2qGhTC7DgVnvLZsUexI2fP9exdQ=;
  b=PzOQRQOPJ2W6a19gnvJKHN5qzLZxuB0xeavSplOba+Zr9AEimoIHSaHz
   F+zp7L07qEpJcVxCqoBngV45QxxG7IZxozZ6UDG61UgNAeoP32TUe+XfO
   9pf0QSlzqhhVktJqzMDkQuER29YB/nvJpbXaafMeK2bECL/pqBVLXb3H2
   CxEXaVGD874CE6z9Ygl7m5etijwC+65MboX+l8aV+E8Pn2gN084L4LpxM
   IiPBnPP4E9Px3vE4eHXltlO0/aRfgwWNGgqJByWnbFSk7cBRd0gGIZu0W
   zLXbm3n/+13MBge1u5lvrnqCobh6hiUgGSl7E1kJvRSIAkBGq4jTR0U02
   Q==;
X-CSE-ConnectionGUID: hSgW0UsGRCKyyqrJovo04A==
X-CSE-MsgGUID: EArE2KHCRzmPD9IA/rKyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61788210"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="61788210"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:42:08 -0700
X-CSE-ConnectionGUID: JHfUXMIIS+ewwYVQQsdaqA==
X-CSE-MsgGUID: hRSYobgzTXm7QAUean/yog==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:42:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:42:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 09:42:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd9eiP7cY17R/snIgFRtNEyfrUUhbHcKT34Q7L6qh+OlNDBp3ftI4Z8qRv64wvAeVPfj764Eznwmu/d+LhKIBQGgkamC0QvzOlxD++3Pxqyf97rID5pqZAedrKxI2CfAWps9cNpP1R0ARkhgEShtBYMLqb/KytvM9lAlGgKO4T2iMXcR8zD3wPTZUiEk6Zg+67BxkUja2Y56U+dultYAm6+Qhcc5FvGTbAQupxY5t1p2TQPzssEVcHFtuVfa0l2ns9zvZI8Uv/FV/cAfsWt9qfOb0lPs3QF5iI42L4bhPmZMYSP09flt2EzZ8vDWiv/SFMuVYxR4CJB08LR3OXC3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4f69oLHzPE5Pfy+2qGhTC7DgVnvLZsUexI2fP9exdQ=;
 b=MZQKgYImaJsEtm0ZxbmoxSFkMIzsvN+NtUNlwfXqbHkT4ynTvmoU76VrOVqRgJXZETMLz+e4tW2Pz+A671vqvBdL1FFpm+rk6JGdVglHsXoe4BVY3QMDs4AiKsF5HVJK3GyObsKVVbQBAhxoK87ukUdLt+OU1XqeubfvAS6MaBmO3wdgeqVDzw0IZoiF3/wUKPLDtHZVHHniSx4QiHvNJt7KOxuFQxlFbmU8opbwSUitll656ywBHQ7o4TypkIO5n/C/eBbpuJwF+M5zXieKGMVO0ArPy/zodmIBlcpRi99rIOIXlqc7W3DYsS9FOuOpT3v/PYpFXcVwmUNWUdD2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:42:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 16:42:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Huang, Kai"
	<kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6VnrQj2eoJJUyFZAbVY/MSfrWmck0AgAGS9wA=
Date: Tue, 10 Mar 2026 16:42:01 +0000
Message-ID: <f49506b734c20e525ff02b784c7ece493b95af13.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
In-Reply-To: <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB7989:EE_
x-ms-office365-filtering-correlation-id: aa3ef98b-3f2f-44b8-b2b1-08de7ec3f40c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: pcusCZXnWqjGI1rUFKn90vb4kV8OMubcsYmXz1zqKh0IONWuHhWzg4UcG/MDXQcrn/nW4yliK2dmd56a0x0MdNekVsyt1rU/uTVoYIUjtR97zoQ+lHTLvr0uvm0iAzl7iyZlIkrh8XKBUkgixf4RqhNB69knR6wuwtz+2tQPLtaQiycRD3dxt85df82im50QI06dPK/IzrCCj+oBSFxHTXqFKSd0BXyut855r+hXP1stRsgZxiUs3jx+Xv8trD/EZPNO2WXZpkPgNzJQG/v3h/LVOEbBqhKtEKD5PCFnnfwJDDDFNFZJ0s07xiynF8eIKxhvMvHssmd1xpvDHnSjHWP3T/4dk7c7xRhpeA7X4En9x0soovpMPD8Lnopw0NsG8K/fjJgKyYwxViVWiR4Cem1nOKvEaDt/0sot82LRdnN8tuRVSI6v7+S3aQJh9teZLCWjcSreb+SVLz+UCyn8iyKfkvnhSDaaFl+Cc5EhfIMRqSxKaV/rdYHh0JKuEb5KoDfWQZ0dxIbUJ/EqZy4/DMrXDzWut4o6beEu5Ss6g8vYMMH5573KSkAaJNbmFu/e6EVaBwVoNgukajV4ZImJTY6LDaxSr4RZE640XnYVQEvf1VTZCF9Hy/tjqJObHHkQ9TJExNYgyfS0W2HKChA7kGOFrkZxyURcb2zIjUtXNpA4Od+InTfBD7hKR0nvNbvF4XEP6rVgL4TyaBb5pK9zD0jBvmnZlGqh69lZIhlepdw9D+lwqsC1q5t8RaThtMz4ohCpCe023uFCfkhKRvMdX6Vcy7qHpV/KU44vJ9l5Pjg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZStQNHNzN1dZVXo2ZVNPY2ZNRXAyNlAwYm9nQkQvbXhObktlUXd3cHREYTUr?=
 =?utf-8?B?VEVJODJnS0FROVhXdXhSZXc4blNSTzVncHE5VDBFV25nRTIzZmxEMldlVnZu?=
 =?utf-8?B?OEhmNDZzSjBuS3I1R01YUnB1Z0VnNEgwdjlxK0szQjYrUnhmenowRGY1dm1H?=
 =?utf-8?B?RDIrSUFOenRPcE1WMEJETVdFTHdKZ3liME5PTTJCaGg0bVNLNkFISndxZFVl?=
 =?utf-8?B?MHJQSjBlUzJpQ1FlVDF0RmRQMWJoNU5aMW1LWi9OdGNjKzNtTS82VmxXRGtZ?=
 =?utf-8?B?NWhGSGhNWFovYjBobjE4bGRjZDRYUnFheVNkTmRFZnFZdS9GSVJQOERrQkJv?=
 =?utf-8?B?NHMvQ3NFem5hUzEwRXN2bjFmUVc3T0xVSDZaNVNhZ3lNWmxoTVZYMTdXWm9B?=
 =?utf-8?B?emNLZEFmMGVlbTVudkI4YnM1dlNSN1FjWFZHZ0E5YTNNMkhsTVVTT0NNUDkx?=
 =?utf-8?B?bHBXR2tqQ3hUbVZrRWthQnVjMktEb2oxRG1aQzhMOURYaC93cVY1YkgreitI?=
 =?utf-8?B?VTVDelFUaFFWcVZjMmpuazNPVjBML2tleG1pMW1KN3FPbGZNYUhPVU5lcGJl?=
 =?utf-8?B?VmNKUlNWUUl4NHlYdE90aHU1QnN0ZldOMzBYMnVIQXZsNXQ4TU1vaVdXYWt2?=
 =?utf-8?B?c2pkZDN6RzJNL2trOWJDVit3K25DUzBDSHFkTk1seDA3MUZ3Rjl5NVRKRGhh?=
 =?utf-8?B?UWFNcHNjNjZGWGlrS3BOVnNlRGx0NUxacUZDZFVZRGQyaFNMMVhxU21qZHlQ?=
 =?utf-8?B?dFFaSFJBOExialozd2F3TEdsMWdtZFI0S3RPcnFiUXlyd3JHdTE0Z1hidXZK?=
 =?utf-8?B?THhpa0VpK05XaUk5ejNoVkxyZjM4a056WDJMb0lIS3prbW00MXVSUDZhaks4?=
 =?utf-8?B?RWFtU0t1RnVoa29Od2gwemdyYjlLeXU3bE9IbWJNWDhOVDQ1dGgvRFNXNVFO?=
 =?utf-8?B?M2VLSXlleWUwTXE2N3VOdHRzYzJGcWhzaCtNYi9PQUFmTXRMOWpaUmlHaVV1?=
 =?utf-8?B?WDdZOXBWOXBLQ1YvcjFuQmdBc0lHU0ljNDJQVXRPQVBnUW5pQW16SXhQV0R3?=
 =?utf-8?B?b3ZQYjlxbVVDMDVrYnNBYUhvaG1yVGE1dzQvbzJmaExjL0w2a0ROM0pUaUwr?=
 =?utf-8?B?cTdvcURoRmNGZWhkU0NveXQwbkZEazdZVkJkenhQMG1JTTkzSXZUYWJvM3pr?=
 =?utf-8?B?M1doUWxPMHNVRVBRblNwb1BsNEpvUjZBMmJscGJzRG9nTS81UnZoWDNLVURk?=
 =?utf-8?B?bER3SFlaL1FiV09abVlEY1FFeDNRMFduVDlCVHlseW4wdkszMHg3b3ZaTmkv?=
 =?utf-8?B?NHhweE1HRHFqRDkwMGM4clU5b1psaHVIK2JCUngyUzY0YWRWbEdPR2tmOGk4?=
 =?utf-8?B?bWtMMmRyOFdFTXNiUmJYMU4xTHpTRzd0aW5xWW43bjl1ekdCVVBjd2lTZktU?=
 =?utf-8?B?MGlYV0thQnlTZk43a0tIZmtMTUxUZ2w2b1R2QkZQWEo1eGRXMytmQWNBYzhK?=
 =?utf-8?B?b3NoSHBhcnlmcXp1djRLWHF0cElUaE9LeW1uYmRlTG5sQXJQZVM0aWI0T3hw?=
 =?utf-8?B?RGtSK2NGd25RcUVLK2djcVlZejRGY3JEWlRQMm9UdXRwekh5Qm4zczJzazJ4?=
 =?utf-8?B?VG9xcU1Rd0Z0SEEzL1Vpeno5dDU0YUpvVnIreXNDb0cxbHVCRS9PMnNwcWFy?=
 =?utf-8?B?U1BpcXhEcUg3ZHFnZGYrSG8zbTdTRmdVL1JKOERQc1Iyb041cGZGMmk0dUJY?=
 =?utf-8?B?cVhaWUdlc2Z3M3hhb1d0djdZamd0Z21FZ1Z6NUV1dDY4RVdDUFNXM2tiZmZj?=
 =?utf-8?B?QjYzSCtPdkVab2FSVlpMN20vVThLRXpXeER3U3Z1c0p5aUhNYW11M2svTEt1?=
 =?utf-8?B?YWdINjBNMXRpRnhtRWJzeVRVVkllZTZqWlM2YUVTVTVmaGZiUmZXWUV2d2RT?=
 =?utf-8?B?ZFZkR2VlSlpPa1RJVTdmQ1BiV3psZGg1UnZ3R1dpOVhZYnByMklyMnlpSVNF?=
 =?utf-8?B?MlpCMlJkcWlQLzRGZ2cvWW9ZYUpvdHY3cE1mWllqZXBpNUpFMmFRWkZjVWI5?=
 =?utf-8?B?R2ZNckFOUnBmOEFjYlc0MHpValoxSGZTNmxFVUhpQ29qSmN4dGJLbktsOUdP?=
 =?utf-8?B?NFVGQ1BCaWtYUisxclBKTGVwczcxQ0JhNndSVVhYb0FvZm5OVDJTVmJJOFZK?=
 =?utf-8?B?YnpEM0w2NWlsRlVXaXliUHFBanFrOGc2c2R1UXRvaHVxZG80dXlvQ203THBz?=
 =?utf-8?B?QU4yZUV4SEpKbFpaQUtUSUhGL2Z0TStRcGEzMXdFUkZCRkRIMTNMTFNxQjF6?=
 =?utf-8?B?bVdIcXdVMTRvQUUwNmFtcE1mQ1FWbTVoeWk0b0lMUisvNXNlSk5XYW1CMWhC?=
 =?utf-8?Q?m/6HZK7vNzpv01gs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5038D6C84BDD14A86F4290C97EB5CA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SuM+/VODZNpkG0GjmDvHoEIoXDA+7OvjaoncN+bTriAGjTAPjrqxHcjOWdhXm0T1GkLqPxQVsoZPpuehsvB9/wdtkoL9W1aXQwJgNiG7RmrBqub3H8VFnL8jtcSe44Dl+Lihj86nippHe0dtX1t3d1BHEtEwDQ9lCKZ4O8If7qfVZt5/dQuMp6uJHmui7UBtbFvz1UWhLYQM0IYtdKNeDC+TBgeJCcMNjsCclsenPsQHD145ny/8Qub1vY8WN8GgqRpc79Tx3CZqipFXwZs6to5vfxAbWUziO1Ool1hw6EKlC1wt0hlSv0H+JwmJYRgq1f1bHrxhGJZkacd/AR2H5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3ef98b-3f2f-44b8-b2b1-08de7ec3f40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 16:42:01.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF+nc+EcFlxuWXcYC4+pk9B0CVPpUBpjQF8jVNXnopPYiS4LZFSFIJw5ZaYgNp3AvkkT1lsYA8wnEeY24pne7trjF4hoJp73f7sifyc1EQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4DE43255017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224522-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDA5OjM5IC0wNzAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbT4NCg0KT29wcyB0aGlzIHdhcyBzdXBwb3NlZCB0byBnbyBvbiB0aGUgdjIuDQo=

