Return-Path: <stable+bounces-72973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A796B45F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A442898D4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8917C203;
	Wed,  4 Sep 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xfnqyfh4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE618B499;
	Wed,  4 Sep 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437878; cv=fail; b=NGCKGMFPz1lt47mmfY9R/gBUSqmXvaDDvaZQbAPf/D8w9nOgO5p1YsR08h4ZdpYPu0/3nh4ocaKG4Ua07mEJLcbgCtZcj7MS2PGu6awrS4XQQaTCEPB/KafYgqZzt3b3Rm57jXsl6brs7gCcEF6FS7IMrSUvf9w2FelB0eNs00w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437878; c=relaxed/simple;
	bh=VwrXN/K66Qrpis4S9k0aQPMozVSMXm3FOaHr9JtHb4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9uX3MWENWzwIaX99tbtXtbR1UNxk/hCfP46n8zm1dpr6OcWWBruIxBDW4Q0JsGwulcQAM9bcI3ssU9W4dv1YWWH4uj4yWkBxK2VY+LUZ7c02Nz8o5k9UMvtLj0D0Eg+h1c1VLesFvnYJfjTsiabySvl9Mz7+12uR63ojZjeDdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xfnqyfh4; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725437876; x=1756973876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VwrXN/K66Qrpis4S9k0aQPMozVSMXm3FOaHr9JtHb4I=;
  b=Xfnqyfh4WDi4a/BPMQQptdQDaE1vLQ2PFN7zu1dJpnEqYQFudp5F28A2
   H9ZmcuELx6Ba7LQ86q1lFU1HbJMCAcoC4WY/ioUjftuF5LNL3pWjePm5x
   R4O9LtxSPZhGgwofWNwzV9RjTZ+4sx6ym0D4HjSoNnHxaX4DAc/FgYdt4
   2v+kpWmch+mT7LMYtzaR+L7w3DD7coXiCeu2BStu4l4zZsfatiR7SjWmD
   n8n+2sD6gGb4Zo77kbOZ9OYMy8YTWA9gmsM5znuAxnpTwpkK4+tzEWhsm
   MGworCqyTmeCR0nNYBoOBdsZgLBEqWPlvCwng3/hcM82NE1PShdRU3FnX
   g==;
X-CSE-ConnectionGUID: +2KkWG+yQlCL3EpdTvd/iw==
X-CSE-MsgGUID: DfsP0qYjRZiMuuBo9J8MyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23641935"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23641935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 01:17:56 -0700
X-CSE-ConnectionGUID: hkGI6xlkQSaTdNWHuO1+LQ==
X-CSE-MsgGUID: rRfTzTTGQzSRzMIWx4piAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69999419"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 01:17:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 01:17:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 01:17:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 01:17:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 01:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M208xXqHAa4LSmpLYIDeGzIi+uFhtgvQI/YxQYG80PYidO47cujWpXHkQr9P+urhrxh4mo/Zl+1YX/eQc+r9zCxp1NHMm26rojECiu+Ya19zWnE/hmFNHdtsbU5ASIA+LWcAIU+p7cZ5PDVzKJ9l/g3spOPoR4ssPHmO1B6jxsOL1sEs+p0m8yAWLr05RcoIawj74UZo08eaNnuWr+yjis2bFo+SW4R6iT91MivD/L39ikwds/LpMUAWUIdNWYknUsNleu/igd0tFqAtdY4gVij6bBj41S8ufF9xtD/q2MGFhe1VC3+Gbb0T1okq2/IRfw6V0hOx2LehM8xUawTV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwrXN/K66Qrpis4S9k0aQPMozVSMXm3FOaHr9JtHb4I=;
 b=kua18LCKFyOZbNo4ONLAyLCxWUI7s0gkY+AVGSwOme5EpWSvoekvBehBohw9dXnxfCRuLv5y6jzGVJ+p65jGN1qXiB+Kfixh7BewcdhIHE8hiTeFqyESJ5sVxTgD5zlYfeVxJrrBEA/ufwUXRMYNJCtRtgnQsF/J8yPbLSeYC+V+SZr2mO8Pq/w4ljZQmE3+0MPADwUUx42syxfgCyTt3RRtNHxHjMlKHxBfXiAE85m1FIl9gi79Gov6WRUw+XvDmo/dd/qRWGiL9fOk+qw3cCLmbpyv89Y7tdYvF7aV/e+jUGqVR/o1MDt/bA34AWYFcCyZWnFY8MAzbwJQXcktdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 08:17:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:17:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "Saarinen, Jani" <jani.saarinen@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
Thread-Topic: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
Thread-Index: AQHa/pE/SLFuiOczDEmMh4cqZcgkZrJHK0KQgAAVngCAAAUH4A==
Date: Wed, 4 Sep 2024 08:17:53 +0000
Message-ID: <BN9PR11MB5276D640C4E906EBBC3EA6D08C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276428A5462738F89190A5A8C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
In-Reply-To: <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6031:EE_
x-ms-office365-filtering-correlation-id: 7aed40e7-24fc-4133-ee11-08dcccba12d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGoyQ1J1dU1JZGNMa2p1ZU5mbXoxV3BrZk9FbDFCbnVDWGtiaWg0RW9TUTZ6?=
 =?utf-8?B?bDkvTHhRQ0JxYjNJRlljK1JQQlJISFk5dUJTcThDSGtaa3JYOU5URXdPZ0pa?=
 =?utf-8?B?YWVOZ29iM3ZHcUdYQnJHeisvNWMyS0VDeHVoMnF6SExZYWhMNG5sYmM4SWdy?=
 =?utf-8?B?ZlFXNklUSTVENmhaZThYUE1uNlNBT2ZRdXVlanlUNjlZTHg0ays4UjBvSWZZ?=
 =?utf-8?B?SXVpS0ljVm1qWlhkK0Y4UXc2VFV2NzJiTkZmb2hmL0JXTGtpSE1IbjJVREs0?=
 =?utf-8?B?OUpjeVBidVROUUFTaW84cGFHbC9VNDFZL2tpUTYxcWRhcDNWWFBiNjVvWWNv?=
 =?utf-8?B?MXQ2Tks1WUR1OVk1amdKUmhtbmZwSDFORERKaFlUT01LRCtYOHU0OVUzQ2lG?=
 =?utf-8?B?V3huaVI0eDArNFgwOURnQzBueUdSa1ZNaGtvK2ZXVlhwTXRjK0RRNkV0ak55?=
 =?utf-8?B?Nk5SdUt1dzVyQmcyN0V5b1cvR2VRRng4QjVQamZFRUlpRkdJSE82TXBoNWtF?=
 =?utf-8?B?cmFJKzhIY3N4Y1VGUGhsQkNRdnJ1cXRPWVFvbXE4STlVTWF5VCszTWJ0Unlt?=
 =?utf-8?B?UTdhOWJ6UVZIQTd0K1o3Rzd3UDdOWThiNWc3elNuSHRrQmNsVm03d1JDVml6?=
 =?utf-8?B?ZGttdU5XM25jaXY1NkhFdlphSzFwU1NyMm03YWhOYVhON2syeEFKaVdRc1Y4?=
 =?utf-8?B?N2h6bXdWV2psYXZtK1dqcVpXL29aVE8wRWVCSDZacG1uNVowc09vUWltbUVv?=
 =?utf-8?B?UGNkajFDTFB0ZzBadlJVNnl1bFYzdUdhRnNDaHRYc1EzWlZGeDNFRSt2WWdl?=
 =?utf-8?B?S2ZCU2c2c2dUaWQrY00rQlRDRUtYOW9EcEdSNklmaCtzRDhNYktHdkJ2ZWhO?=
 =?utf-8?B?SnZSSTZzSTdUWWtrZDBQMWNxS1lIMGNkMlNwUEJQaUlwdzJhRHY5VDY1ZTlX?=
 =?utf-8?B?RWxiRldYQVJSNjNSVEtCM0R1L0NqM01TYVhtcXgyeUQ5SXdSclQ0TExiYnRr?=
 =?utf-8?B?TW01NzRsMXZmT0xXYllNMUNPMldiOW1wdTBrN3h2czNKekZRQys4NERDWGll?=
 =?utf-8?B?RWpVUlh5QVNPQTBrcGJvK2N0S1pGOUJWWjZEVUpuU0FxbVdvazJGbHZhTTdW?=
 =?utf-8?B?Zm9rVGw1dTRwRXpoaVhxSGZiRVRta2VyZkZleFNMR0ZVampGMzhZaFJUR0lX?=
 =?utf-8?B?ck1PbXdyL0FzZ2h1MDI2VkFHQzJNZ2N4b0xDb0kzRGNQbmxodCtXMlRHb3I1?=
 =?utf-8?B?aGttUDZsL0ZLdUhsWDErd1JyaGZqbEJvMG1EOENrM1BvaDZPVUlWUDMzS3Fo?=
 =?utf-8?B?UjF0ekdsWUVOajVwMTdjb3oyKzg5K2NEbzJxUm54S3hTNkxrVDlRWGd6TnVY?=
 =?utf-8?B?L3BaZHlKdnB4eTZPbWZLZ0ptMzAzdTFQTnBqWVBwVXg5M0VFMUtzVmdtZkZ5?=
 =?utf-8?B?d0R6cktsbnJDOHYvVTVqYmdTVk92WFpMa3cyVFR5SDZrditjNTRCTkVFL0c4?=
 =?utf-8?B?ZVZiQmYvbEd1L2NkNGRkZVh3am1penR2d0txZ2hvZ2JHdXNCeXRiTmhlVzBG?=
 =?utf-8?B?RTkrRExPQWFrUlA2Q1ZicVlER3hWUDVROGpWSE4wMk5pTzAveG1ORmJmL1JH?=
 =?utf-8?B?TzdyeTZUYzM1RXZZbmFBaEwzOXRFd3FMYlU0SVRSVmpVdUlGN0RmVjF6NHF5?=
 =?utf-8?B?UmlYR2ZjNFhKNkxjaTJ3czl2Y0wxTGEzbzk4NzZkZ3gza0tqa3JkQXp4ZjE0?=
 =?utf-8?B?QTc1LzdxV0tadDhiRmVqUitTV0todUVSQ3M3WkkweXQySkd4TW9zZmR3bUhX?=
 =?utf-8?B?SThBd2J3VHFUWDZyN2Q2MXFFejZZVVZpNmtPam5OWVlFbzNTR3R3bFdFOXVt?=
 =?utf-8?B?TVpKQTJhSnBXSDhzV0VUY28yV05YblBpeTNOOVM3cTkxdkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFROb2JWTUlwQTJIL2YwZ2tyeWwzVzFXaEVwYmU2V2JBZmpCcHhjeTN1UGZ0?=
 =?utf-8?B?TStaQk9OUCswd0h2VDNzK2tCTUxSamxjbm1QMTFjMWFDSmJwNUNJSU9yRTBT?=
 =?utf-8?B?a0h2THFDcEVaQVdrbGRVZWJTRTcyblNHb3RmN2EzR0xCWm5VMjNrTUJnZ2JJ?=
 =?utf-8?B?aE5FQTdGQkpkeGJyZ25KU285Mmk2d25vMk5nYm45VHlOUGNVMlNFTUJQd21F?=
 =?utf-8?B?U1dYQmVnSExZdkhpWTkwYWNXTWFWcDVBbVJLUktld1BZYXR2eGd6andaWDdZ?=
 =?utf-8?B?c1hyREJ4SENZZURaeXpjODhCd3hEdmk2THRFc0IrK0RWTzFyMUcxdXpabWVz?=
 =?utf-8?B?M1hzdGYzTWFBcmRJNnIwRzhNcGpJQmJQOWZVRnlnbVEwazFSNWtRRDBKOS9O?=
 =?utf-8?B?NkVuRldmUjBLMWlHTmFFczllNHQxNGlPMWk3aFFJNHBkWkJ6ZmFVTVh0Qm9k?=
 =?utf-8?B?RXZ5MmEvR3lqUE9ua2pFLzZFZ1luNVl0T0NPU0l2cjl5ZXNyVTFCOFpzeDIz?=
 =?utf-8?B?UVJhVC9xN1FGK2dQNVlxamU3aWxKWm9sWTgyOFBXTlFsVUlzSHRuZjE1ZUlF?=
 =?utf-8?B?b1ArS2kvU0dPNS8wK0ZpenV6SVp4dCtrYnozL3ZEQWtxWnJ0cUZVNG1WbjlX?=
 =?utf-8?B?Y1puQVpPdldDRTMwam1XNmZHQ2VZMkhFdDFZc2hjSkIzVE0zRGRnMjRFbE1L?=
 =?utf-8?B?QXFsZTRYYWhabjZQdDFjT3J2ZTAvOTBIb1dVQWJiRXZkNUg2NDY4Yk91d213?=
 =?utf-8?B?cW1pTG5Gd29uQVAvZDE0allNNG9GR29kWUNDWnFGemNxR3EyYWVNSUtXbGxK?=
 =?utf-8?B?dnFhYzRwbGlBV1g2YnVoRGxrUUc4SEtoTE1XUHZNZVIvSUIxenBVU0RZTzVV?=
 =?utf-8?B?N2c5T3l5WDAycFdHeHZPeHBMdlNERGJQZ2MraGY2VHJ1VktVcXp2L1VZcGNF?=
 =?utf-8?B?UVMyajJSMFF6RVlPREhSa281aUxBWGtySEhsT3hiZEF6a2dKQWJOdkdEQzZG?=
 =?utf-8?B?d3J6V09nZ1JyUHNRZUVZbnI4aDhQLzlHQlRmclU5TXFZNXowWGJmbUlqWVVF?=
 =?utf-8?B?MWVNRmRkOUp2dDNRTElMTXV6ejhSZGlSRnZRYmNOTVp2dmx2RHFGMTBWNkhw?=
 =?utf-8?B?VThkMGU5RVlTK2ZPcDZicDhvODZ1d1A4d2czWFo2cXA5TktxbnBJOFV5SUV4?=
 =?utf-8?B?ckY0ZXBQOTFYWVgxVGs3SURWUWVsWWdDUjhzLzQ0Q3ZEVzIwR05rcm9OYWIz?=
 =?utf-8?B?VkQ3bGRJUk5nOGdVMCtOb09PQnM2V1R0VlRJb0ZucnR3bkhjcWZOa25mMmN6?=
 =?utf-8?B?R0lZK2ZJOVJXNHRNclkxU2lMRGdzQXd2NEtCZk9WN2Vkc2dHTDJqZmhVb0FS?=
 =?utf-8?B?OGFOU3M2b2NyQ2o0aXlvODI3Z3RHeGFHQld3K0lKako1cGs1UmNCaWJuV0xO?=
 =?utf-8?B?R3N4dkMyRkdOK2k2b0pEN3BQQ0lueFJoVmlKV1M0amc4ZzlrdGhHTVVKellW?=
 =?utf-8?B?eDFOYUZ1MEJDSitOc2kvanRVUFFObTJHRFgwMlJVVEVDTHJLWFN0NUI4eVlG?=
 =?utf-8?B?Ymt4QnpkSXNObUJGOUVIdThDWWN1dkpFT256aGJBdXZibVRQRGhuRm04Szlj?=
 =?utf-8?B?RVpBVDUwMGxjUWw3cTN5OUU4QUJwZEREVi9RaWNvNXg3bk54MUphaVhQN3RH?=
 =?utf-8?B?Q0x3K1IxU1RDSGlSUGJvbE5LQ3BudDlpekcwMXMrdE02QlVmOGtjMzZYVFly?=
 =?utf-8?B?WDdGWTZGY01MS2tzVzhzeDdwamRPYWk2NVRHOEs0MzdZeFl4Y2RCbFFpY3pT?=
 =?utf-8?B?VWRuc0lFQ1pPWnlEMmNXOWZqa21wS1Eyd3cyYU9Fc0NsWlh0V3NEY0xlOWVx?=
 =?utf-8?B?L2NXcHMwWlhaSjVZZmdiZG1yYm91U0dBU01qR2FjRDNzcWtUL0ZoV3NZRzcz?=
 =?utf-8?B?d1pxSzRIbmVxWnVFMUMxai9EYlJuMmJ2RlV2NTN6eWduK1VnMGRSMmtKNUdt?=
 =?utf-8?B?Z1dyS3M3WXVjZmxjTy81N1ZUMHAzeG5uUStZei95N2JuQVFjVGozZmdFaU8z?=
 =?utf-8?B?SWVkMytKeUFiRzVZeDV0U2o4TWZHQTh3Y1k2VmVBaTYwV0NqWk5zaVdjeGNO?=
 =?utf-8?Q?yqTKWyoKmac6SUlykNtSN4kSr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aed40e7-24fc-4133-ee11-08dcccba12d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:17:53.1259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrIIKB6G5iK6CohztDavmnh+dzkove3VN4lmBdC5m9hF+i1swyoQtCTxhpuDjgxwsZa0wnlvJ0X1Wepuhz3M0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciA0LCAyMDI0IDM6NTAgUE0NCj4gDQo+IE9uIDIwMjQvOS80IDE0OjQ5
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAyNCAyOjA3
IFBNDQo+ID4+DQo+ID4+IFNPQy1pbnRlZ3JhdGVkIGRldmljZXMgb24gc29tZSBwbGF0Zm9ybXMg
cmVxdWlyZSB0aGVpciBQQ0kgQVRTIGVuYWJsZWQNCj4gPj4gZm9yIG9wZXJhdGlvbiB3aGVuIHRo
ZSBJT01NVSBpcyBpbiBzY2FsYWJsZSBtb2RlLiBUaG9zZSBkZXZpY2VzIGFyZQ0KPiA+PiByZXBv
cnRlZCB2aWEgQUNQSS9TQVRDIHRhYmxlIHdpdGggdGhlIEFUQ19SRVFVSVJFRCBiaXQgc2V0IGlu
IHRoZSBGbGFncw0KPiA+PiBmaWVsZC4NCj4gPj4NCj4gPj4gVGhlIFBDSSBzdWJzeXN0ZW0gb2Zm
ZXJzIHRoZSAncGNpPW5vYXRzJyBrZXJuZWwgY29tbWFuZCB0byBkaXNhYmxlIFBDSQ0KPiA+PiBB
VFMgb24gYWxsIGRldmljZXMuIFVzaW5nICdwY2k9bm9hdCcgd2l0aCBkZXZpY2VzIHRoYXQgcmVx
dWlyZSBQQ0kgQVRTDQo+ID4+IGNhbiBjYXVzZSBhIGNvbmZsaWN0LCBsZWFkaW5nIHRvIGJvb3Qg
ZmFpbHVyZSwgZXNwZWNpYWxseSBpZiB0aGUgZGV2aWNlDQo+ID4+IGlzIGEgZ3JhcGhpY3MgZGV2
aWNlLg0KPiA+Pg0KPiA+PiBUbyBwcmV2ZW50IHRoaXMgaXNzdWUsIGNoZWNrIFBDSSBBVFMgc3Vw
cG9ydCBiZWZvcmUgZW51bWVyYXRpbmcgdGhlDQo+IElPTU1VDQo+ID4+IGRldmljZXMuIElmIGFu
eSBkZXZpY2UgcmVxdWlyZXMgUENJIEFUUywgYnV0IFBDSSBBVFMgaXMgZGlzYWJsZWQgYnkNCj4g
Pj4gJ3BjaT1ub2F0cycsIHN3aXRjaCB0aGUgSU9NTVUgdG8gb3BlcmF0ZSBpbiBsZWdhY3kgbW9k
ZSB0byBlbnN1cmUNCj4gPj4gc3VjY2Vzc2Z1bCBib290aW5nLg0KPiA+DQo+ID4gSSBndWVzcyB0
aGUgcmVhc29uIG9mIHN3aXRjaGluZyB0byBsZWdhY3kgbW9kZSBpcyBiZWNhdXNlIHRoZSBwbGF0
Zm9ybQ0KPiA+IGF1dG9tYXRpY2FsbHkgZW5hYmxlcyBBVFMgaW4gdGhpcyBtb2RlLCBhcyB0aGUg
Y29tbWVudCBzYXlzIGluDQo+ID4gZG1hcl9hdHNfc3VwcG9ydGVkKCkuIFRoaXMgc2hvdWxkIGJl
IGV4cGxhaW5lZCBvdGhlcndpc2UgaXQncyB1bmNsZWFyDQo+ID4gd2h5IHN3aXRjaGluZyB0aGUg
bW9kZSBjYW4gbWFrZSBBVFMgd29ya2luZyBmb3IgdGhvc2UgZGV2aWNlcy4NCj4gDQo+IE5vdCAn
YXV0b21hdGljYWxseSBlbmFibGUgQVRTLCcgYnV0IGhhcmR3YXJlIHByb3ZpZGVzIHNvbWV0aGlu
ZyB0aGF0IGlzDQo+IGVxdWl2YWxlbnQgdG8gUENJIEFUUy4gVGhlIEFUUyBjYXBhYmlsaXR5IG9u
IHRoZSBkZXZpY2UgaXMgc3RpbGwNCj4gZGlzYWJsZWQuIFRoYXQncyB0aGUgcmVhc29uIHdoeSBz
dWNoIGRldmljZSBtdXN0IGJlIGFuIFNPQy1pbnRlZ3JhdGVkDQo+IG9uZS4NCg0Kd2VsbCBkb2Vz
IHRoYXQgZXF1aXZhbGVudCBtZWFucyB1c2UgUENJIEFUUyBwcm90b2NvbCBhdCBhbGwgKGkuZS4g
ZG8NCnVudHJhbnNsYXRlZCByZXF1ZXN0IGZvbGxvd2VkIGJ5IHRyYW5zbGF0ZWQgcmVxdWVzdCBi
YXNlZCBvbiBkZXZpY2UNClRMQik/DQoNCklmIHllcyBpdCdzIHN0aWxsIEFUUyB1bmRlciB0aGUg
aG9vZC4NCg0KSWYgbm90IGNvdWxkIHlvdSBlbGFib3JhdGUgaG93IGl0IHdvcmtzIGluIFBDSSB3
b3JsZD8NCg0KPiANCj4gPg0KPiA+IEJ1dCB0aGVuIGRvZXNuJ3QgaXQgYnJlYWsgdGhlIG1lYW5p
bmcgb2YgJ3BjaT1ub2F0cycgd2hpY2ggbWVhbnMNCj4gPiBkaXNhYmxpbmcgQVRTIHBoeXNpY2Fs
bHk/IEl0J3MgZGVzY3JpYmVkIGFzICJkbyBub3QgdXNlIFBDSWUgQVRTIGFuZA0KPiA+IElPTU1V
IGRldmljZSBJT1RMQiIgaW4ga2VybmVsIGRvYywgd2hpY2ggaXMgbm90IGVxdWl2YWxlbnQgdG8N
Cj4gPiAibGVhdmUgUENJZSBBVFMgdG8gYmUgbWFuYWdlZCBieSBIVyIuDQo+IA0KPiBUaGVyZWZv
cmUsIHRoZSBQQ0kgQVRTIGlzIG5vdCB1c2VkIGFuZCB0aGUgc3ludGF4IG9mIHBjaT1ub2F0cyBp
cyBub3QNCj4gYnJva2VuLg0KDQpJJ20gbm90IHN1cmUgdGhlIHBvaW50IG9mIG5vYXRzIGlzIHRv
IGp1c3QgZGlzYWJsZSB0aGUgUENJIGNhcGFiaWxpdHkNCndoaWxlIGFsbG93aW5nIHRoZSB1bmRl
cmx5aW5nIGh3IHRvIGNvbnRpbnVlIHNlbmRpbmcgQVRTIHByb3RvY29sLi4uDQoNCj4gDQo+ID4g
YW5kIHdoeSB3b3VsZCBvbmUgd2FudCB0byB1c2UgJ3BjaT1ub2F0cycgb24gYSBwbGF0Zm9ybSB3
aGljaA0KPiA+IHJlcXVpcmVzIGF0cz8NCj4gDQo+IFdlIGRvbid0IHJlY29tbWVuZCB1c2VycyB0
byBkaXNhYmxlIEFUUyBvbiBhIHBsYXRmb3JtIHdoaWNoIGhhcyBkZXZpY2VzDQo+IHRoYXQgcmVs
eSBvbiBpdC4gQnV0IG5vdGhpbmcgY2FuIHByZXZlbnQgdXNlcnMgZnJvbSBkb2luZyBzby4gSSBh
bSBub3QNCj4gc3VyZSB3aHkgaXQgaXMgbmVlZGVkLiBPbmUgcG9zc2libGUgcmVhc29uIHRoYXQg
SSBjYW4gdGhpbmsgb2YgaXMgYWJvdXQNCj4gc2VjdXJpdHkuIFNvbWV0aW1lcywgcGVvcGxlIGRv
bid0IHRydXN0IEFUUyBiZWNhdXNlIGl0IGFsbG93cyBkZXZpY2VzIHRvDQo+IGFjY2VzcyB0aGUg
bWVtb3J5IHdpdGggdHJhbnNsYXRlZCByZXF1ZXN0cyBkaXJlY3RseSB3aXRob3V0IGFueQ0KPiBw
ZXJtaXNzaW9uIGNoZWNrIG9uIHRoZSBJT01NVSBlbmQuDQo+IA0KDQpidXQgdGhpcyBkb2Vzbid0
IG1ha2Ugc2Vuc2UuIElmIHRoZSB1c2VyIGRvZXNuJ3QgdHJ1c3QgQVRTIGFuZCBkZWxpYmVyYXRl
bHkNCndhbnRzIHRvIGRpc2FibGUgYXRzIHRoZW4gaXQgc2hvdWxkIGJlIGZvbGxvd2VkIGFuZCB3
aGF0ZXZlciB1c2FnZQ0KcmVxdWlyaW5nIEFUUyBpcyB0aGVuIGJyb2tlbi4gVGhlIHVzZXIgc2hv
dWxkIGRlY2lkZSB3aGljaCBpcyBtb3JlDQpmYXZvcmVkIGJldHdlZW4gc2VjdXJpdHkgdnMuIHVz
YWdlIHRvIG1ha2UgdGhlIHJpZ2h0IGNhbGwuDQo=

