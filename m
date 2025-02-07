Return-Path: <stable+bounces-114218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B0A2BEE2
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E893A53CB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF21D61BC;
	Fri,  7 Feb 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTPDCI3o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEF1AAA32;
	Fri,  7 Feb 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919598; cv=fail; b=mtvkVhBLcgiF51Ss6YaVXfNTv0eSNBCyGWvo3SbrQa9IbtFLsMLcX/n+tQbzcO8ndbIFrlzROpJvMtDkCu6e7O2s+NO82z+uctHHKRveT8cRzPZK1KtQFMk8vRuigiMgCTgzlCbafIfAIxj1MRVFf7D8+dkOL/vUxy6viMXZCPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919598; c=relaxed/simple;
	bh=8mPk4XLdKN36zkA03qKyznIXQ4Ggwxa6IYRpZ5h8mUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RupdSUHmaWCICNRAcvsj/KZG4uJpRpoBijvNqRZ7N9t+DikFm/WipT8hix2BRSVKvE7S7Z2weTUcQD9xs/lXFhJYroavfiI67rlaAQInbQfCL6PB9Fj3WLconBW9JsfMXyOiNriLCkdYOhY20YV5t9JkBuFdqqksGbqqYN+qWIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTPDCI3o; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738919596; x=1770455596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8mPk4XLdKN36zkA03qKyznIXQ4Ggwxa6IYRpZ5h8mUY=;
  b=GTPDCI3o9zzrg+r8plXl9I0Cqyb/pZOgTOn/H5pK6WPPEjuyVE2lAbQU
   PTISesewzaaEN7ma4T6ED7J0rzPjuA79u/yHo0LPTNphwZacz7GZrGDnn
   5gUPgb/Blef6SXMQOZMAbPrStsrZWQUMCBbigQ/v+zmYOKy8y/lmdbFEL
   YfDys5vEXtz+AdMup67Dup1lOz6bAa1q+BCT9IN8HNP248HCbBvquHpQN
   Ary6KSQyHm+Xh6AwHs3BM6h4h205A2xo0wrUOtRN8FH8oXnQphl5ORERk
   S/LvGSgW10aQ6cQE0HomQCaJP6+jyye3g9MJ12s+zaNua8POqcBtnrUo8
   Q==;
X-CSE-ConnectionGUID: bCH7bhk9T4SMOjJsw3sFbA==
X-CSE-MsgGUID: teOBZ/eHTQaHoy+hz3I4JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39582341"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="39582341"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 01:13:15 -0800
X-CSE-ConnectionGUID: HOK1jeAgSGSVmzgwq6FMkA==
X-CSE-MsgGUID: U0dYRMJBQAO7BGC/YP0sLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="111672595"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 01:13:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 01:13:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 01:13:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 01:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiNdqRhu+sDCLdYAAw0n38JS3E0rDGFu9tDGwXvBgJZlBUrrItinO2pZdLKbkOrMbzBD9Gf6crJyS8Xs76zBh+iRaUQA5frCeSo06PDiCNp6Pwje+1Dy6Fpg/cJfpPPOIoZYksHe/RaO70aktetJEe3eB3GZj/HABKmLYwJTkDN/sf24+lDqFrkQGPhBVIxwpzQR5HppLyy5J9P+FnMYWw56sNxqPzl3dNuDG34tfBPCX+9yaBmVByoyavLh8XEee3fyW/jLpKEG1agmgXkkVkQpBekUVfCbEZw+0rpVexoQfQPfZK0pcF1ehN87jRvKeqcF1rZl+aDaVNfTWnV0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mPk4XLdKN36zkA03qKyznIXQ4Ggwxa6IYRpZ5h8mUY=;
 b=KuWRcOcI2kgPfxpbNctap+wli9jiMTkqXQtPDyLjCjhHOEGSsYlewVAbIczGENddkzjqXDaH2y/ASuezrLp+VX4Tm3H+5NHr+8Wg+LqTXPkEIBc0mduHzaWReRUKQ9zSzYiVnPFb4HbCdDPklc3615Fif+agR/baFDow2UgSL6qP0abGR2HdZ4Ro7Ss0wpMQIIDSEdHj4UNco4AFoqcHZ2b0dL/k5juF53tCGMZozS6/GmrOIjeIr79cApqSCyPcds5NlNzapNcmSkvPKaXThsY18b0edVx4UecuSJ/JRRfJmTyLyPfV/czdKS8X8sNhxQb3WRmNLPEzAI6o8c0JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 09:12:44 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%4]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:12:44 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux@treblig.org" <linux@treblig.org>, Shen Lichuan
	<shenlichuan@vivo.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Topic: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQCAA0UcDoAA++LggADu3AKAB1OZ0IAAI5krgAAWHVCAADB9joAAB7ywgANXOxWAAQkp4A==
Date: Fri, 7 Feb 2025 09:12:44 +0000
Message-ID: <BL3PR11MB65320CBE12D13EBD3940CE44A2F12@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	<874j1i0wfq.fsf@bootlin.com>
	<BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87msf8z5uu.fsf@bootlin.com>
	<BL3PR11MB6532451B44E7C5D82F5EC4AFA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87o6zi83se.fsf@bootlin.com>
	<BL3PR11MB6532369D14375CC94AA2714BA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87frkt96nw.fsf@bootlin.com>
	<BL3PR11MB653239DDBD9D8E7D413B60F4A2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
 <877c6357o5.fsf@bootlin.com>
In-Reply-To: <877c6357o5.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: f86a14e5-48e6-4cd3-4c4e-08dd475794fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXNmRnhRSGpKWFNPaXkyUDZ6RnhveHBzYm1WNUJyei9wNjhKQm9kbW1KeWZx?=
 =?utf-8?B?WXQvOFZxbG5XdWs0SWZwWmgxM2xONElzMUFTVUF5RzhYa2tIMmpaa1VMUy9w?=
 =?utf-8?B?Y29pZmRCTjJ3aFYrNmsxZVY1VzBqL1VEUUxmeUdmVjdCaDBZbWZFdEVUTjA3?=
 =?utf-8?B?dWNrNjI5UnQ1ZDJTdW5EQU40enhYK01XeGVMRk4xTS9laHVST0VNM01GZFd2?=
 =?utf-8?B?aTBlN1VDcy9MSnlwcGJuYk5RbzRkMDBxdmYwS09GblNEdmkwU0t2U1pibS9i?=
 =?utf-8?B?blE1T1dBY200dkhyKzVEbmRpTWtNb0VxTjNMYkUwUytKUmRyYlV5S2JmbU94?=
 =?utf-8?B?TWJBU0JyYyt2ekdYWjQvMkhQM2kvMFBYWnAwYlVVRSt6MmhZQThwS1pidVM1?=
 =?utf-8?B?Y0FzK2FOWEx2OC90WThVdEEydkp1Rm1ud0I3NWpyMElyQXVaMkRNdHBLUDA5?=
 =?utf-8?B?SEx3NUVkOHFXdm9JNEJkTVh6TEVKMjYzUHRjbFB4MDdyUkh3L2Z5cXRTVHNV?=
 =?utf-8?B?V2o4ajBBYXFXTDFKcmpUazFsa2tTYWdyUEwzMzNUR1pSc29LWWl6MUZoOStj?=
 =?utf-8?B?aEFVSGl4RUR4NmFhblNGQ1NKSktiUk9ubnRGVjdTdEMvZndNUnZEOS9nanNF?=
 =?utf-8?B?NU1RT3dmbmxOUy9QZ1VWUS9XaGxVQXY4cDByMktiSnE2T2ZiNkFQUEwvbC9m?=
 =?utf-8?B?OVpUeEJUSkNaQXUxQ040WnlIM1Z0eE04aHlreW5OVW9lVlpta3lRUFZ0Wi9O?=
 =?utf-8?B?b0cvTHNGcVNXOStnUktJN1M1YUxJb0Q4MXk1QWFUcWVaUnBGU1VGN05UZFVQ?=
 =?utf-8?B?QlZRU2M1T1lDR0phR2hucDlrMTFMVW5RcGJOa0xJTnI3Q0dNTEE5NmtTRmUz?=
 =?utf-8?B?WWRvTEdlUHV1NG5Nd3hseWlvV1E4aW9JWmNWMXkyN055dmJobnJDRzRaKzlL?=
 =?utf-8?B?N0dqM3laYjE0SjdnTTRDUHhzL1JocnMzTjhLM2gzUWc2eG8xbklmMDh5d1Ra?=
 =?utf-8?B?U2JITDdBUFhuSDZJMUoydGZ2S0hVVXltKytoc1o4Q05kREx4QlhCRGR6RkVw?=
 =?utf-8?B?NEFCTTM0cVlLOWNWeHU2UDI3eXJjeExZZnQ5bFo3UlUrK1UyYTR0RTFudC9z?=
 =?utf-8?B?TVUvRXQvbWNNLzBvZUw0TzJrL2FzbFYyTlc5VmFyTS9LcGNjZkxuLzZjUVNm?=
 =?utf-8?B?QmFKTFh0cmNZWkNJTUlNY3JWb2Zod3ZjdWliTmRaNmNnZDhzbElnYlNWczcw?=
 =?utf-8?B?RHkrZlNyK0M1QW0va3lOYkFEY2Y4VUZqZi8wdW1qbngycGlWemVBcFRBaUFp?=
 =?utf-8?B?ZEl4aWR4dmVHYXU2alVLUm14MFZzb0dEWFpmeklHNkxnQVJlZzdtMEhDR2c3?=
 =?utf-8?B?YkNxZCtoK09acVlWR2V3SUNoc3FRcjVYZ05rb1hWL2FaczQ1WTducG5KNnNJ?=
 =?utf-8?B?VUp6WTRJRWZKOVVJUjE3MXAyOUgwVTc2WEFjckJFcHQwSVI2Sit5QTdpeTZF?=
 =?utf-8?B?RU1WYU92U205NzlnUnlXUnBvTjI2MjJieWFhY21rbUFuRng4VkYyVC9ITytW?=
 =?utf-8?B?a2xHODFXOWloYk9ScnlxWjRTeldlVkxEZTVBZ2hWQUY1VVpMVk9LNWFWNHVH?=
 =?utf-8?B?S1oxK1lEOHhxSDZhTnprcmFRYUFtRnBuZzlrREY3Y2V0eWd5b1RtNjhnMFUr?=
 =?utf-8?B?MTVkajFReWR4elZ5bks0aUZDd2wxOC9oVzlKajFmeE56ZFRiQzdNenZMeUYv?=
 =?utf-8?B?eFFXRE9iV2Z3NG9Md2FUbFRwVlE5UkdMRDhiaHVDWkNpZ2lObURhRnJzODJp?=
 =?utf-8?B?M0JoYTFhL0Q1ZDhndk9VampSVFNJWXpleXpYdW9ld3VXM0c5ZXZONTRCSmNw?=
 =?utf-8?B?UGc4SlF0WW9BbDZLeXByc2VqR09qYW13U2FUWDh6VENpOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnlaS1BveWR1dGl0TXBSY0IzaU1lWG9JbFk1aTlCY0gxdFRsV3F6eFdidFA2?=
 =?utf-8?B?TXUwKzdhaCtMQmR1UmxoMWh4VUVTb2FIM1RsSndzVk5pLzVqdGR2dGtaNU9a?=
 =?utf-8?B?dDhXNWF3djhwWlF6dnRWM3B3eU5NMHVBTTZELy8zQ3hJOFBva3hCK25Nbkdl?=
 =?utf-8?B?M3RVNGs2c3VYR2NUMGk5Y04zOUxUOUNKT3loQ0l5dEp2VWZpb1g4akJ4SWlL?=
 =?utf-8?B?M2hWTzdtcWxrQjZ5TktjUFgrMGZ5VDJKaGMzbVpoREtzZElXd29XajBXOWVG?=
 =?utf-8?B?V2xXWmxqSmZkeU96ai9GcU1NRmZvRFVmMmdzT2M1bzRqSmxmWnBRZlhKTmgw?=
 =?utf-8?B?T3ZGNkNBV1oyZkxzN2hFSFNOUlRkbTFqWUNFMlE3UVdkaUVBTitzVUdlYXhx?=
 =?utf-8?B?TExGWTlkak5NMkhVL2Y5WG1vSWxvV2hvVFMvQnZFdjliTFZiWTRsVXBGVThn?=
 =?utf-8?B?NlBkNm5BclJZRjY5U2w0NTU2WWoraEZyTkp2MVhkWDJwUU04V2VsdURlcVUy?=
 =?utf-8?B?NE9CQXk4VGlpM3doYVZzUTZsMldQVnVXZzhyRDVXODJObnhFZ3hsUVNuVFBr?=
 =?utf-8?B?UnlxbmVjNldBcWtZNUdrR0tudmdMWkhsMkdGTjMvcmRXVnBtOGVZdWVqZjhy?=
 =?utf-8?B?ZHErTmV6azlEaklNdS8rV2FTbzNUZXFQTE5WTHl3NTEyMWwwZnY2Q2JPT255?=
 =?utf-8?B?RE5FZnlQT2ZiakVGRm5qakt5RzZVcGxQQ2M4OXZQQWR6ZWt5UXREU0QwcmxN?=
 =?utf-8?B?UmU2NU90L2ZmWUxDekVqMXhTT3MyTlo2UkJtekFlQjM4SGoya054b05HVFNM?=
 =?utf-8?B?cUJPek05bGh0Nnk5YmtONUYycmNPZS9UK0RQVWVYOFNhbGVDbnFsNlE3QTNW?=
 =?utf-8?B?N3FZc3FYODZpc1BvWEkzL2FXU1VQOUFlMkdLelExYlRLQlhiejNsVDFpRVp0?=
 =?utf-8?B?Rm9kbkRvSVROY2VNczlpbXg0ampkVEhxeVN5UGg2aXIrcjRIMTBTWkkvc2xx?=
 =?utf-8?B?eGR5ZVNnc0t2bkRGMEtBaDlDa2ErSXk0OGJxZi91YVFxUFFpU0V3SXdHK2FU?=
 =?utf-8?B?eHhBbHo0NFZ0ODYweTNpRFZXNk9zbm5JcEkzcW9oVnZMNVRaZ1c4SG4wYmVF?=
 =?utf-8?B?WTYvaVJlRVd4R3kraVVaa1hHbERGOTk3djJvS2x1TWswL0NEVW8xb3F3T1Ru?=
 =?utf-8?B?ZUhRc1Z2UVcwK0svaTBqMWRSSFh1WjcxUmlXckgzdDY4QU4wMGsvU0krQmZO?=
 =?utf-8?B?ZXlDbnAzUXF3R1lSM1JHWVdRODZ5clNHZzVvRzkxckJjZUdSbWU5U1lIc2x4?=
 =?utf-8?B?K1dpemxodm5jVUg4cFA4OWpMQi9NUDNWRVkycEI5NUpibTk2V04xeDhWY05j?=
 =?utf-8?B?QmV4dDJuTG9DUzljRWszc2ZNTC9tYmQvQWZOSlZtTzRjMWZOcTdKbHZvcGQx?=
 =?utf-8?B?YVBHRXZJdlgxVXB5VmRtaElnUzhObjJ4SkZESCsyb3NQeityV1NTK01uei9J?=
 =?utf-8?B?RkR0QUhKSndwVHB4RENMMC9EQVRMM2l6T1pFUjBYMURxeHVTK1crMC9wcndW?=
 =?utf-8?B?MTgwbXJLVjJELzVycUNTNmFBUUhYWE1DNEdwbVMzbUZDbkVnSmErT3FGSG9t?=
 =?utf-8?B?cDhGNW93UlNOSHI2cDNGTlpEbDM4eGM4MzBvNWFac0s5L1ZmQUpYak5vMlk2?=
 =?utf-8?B?dmVtK0pUbHlDYlg1WnlyQ1RjNXo3dmtORnk4SFlRQ2RQVE56WndIS3Z5V0dh?=
 =?utf-8?B?aXlKblp5clZsQjlKNjJjNUVNcmtuZ0V3ZHRiYml2YVE4c3FmRS92N3Rvek9v?=
 =?utf-8?B?bHdCclk2MGsvWkdaS0VOR2NIVStOczBHVkx3LzJ3VkR6MGVjNjI5UkJvMU5H?=
 =?utf-8?B?WHFyRkVsQnloVVR1eG5sUjZWaTVyaW9GcnRtZExpdmhuM29lRnBmT0tNTW8v?=
 =?utf-8?B?TXFkck5Dd1R5UnBaaXRGT241VEdxSWJRZVJqTHdvUDYvRzVCUlhXaXllNU0v?=
 =?utf-8?B?aVpKV0FzQkNVOEt0TkYrNE1wa05mMS9oL3pPOWVWV2E0MUpXK29Vc2lEQUlr?=
 =?utf-8?B?SGtUbHlkTG4zVjBrcmNZRzBVMXY1RC8yVDhJVEhZUnZ1VW8zWG5ZRDN3eFJI?=
 =?utf-8?B?bFN6YTNDRFB5Smw3a1ZWRnJVc2dpZFZIU2gwL3VPL0JFTFNURGdncnhpeDBl?=
 =?utf-8?B?d2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f86a14e5-48e6-4cd3-4c4e-08dd475794fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:12:44.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/zytUbuSE6owIg2lQX25qUSi1IJIpf8e8Bm50b0WOoJvdxK56hV+m9s5blv2/c13HO4K/j6/dCuShItksspJIs6MShQY9kLBvOuDgqyC8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IEZyaWRheSwgNyBG
ZWJydWFyeSwgMjAyNSAxOjAyIEFNDQo+IFRvOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmlyYXZr
dW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hh
cmRAbm9kLmF0PjsgVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiA8dmlnbmVzaHJAdGkuY29tPjsgbGlu
dXhAdHJlYmxpZy5vcmc7IFNoZW4gTGljaHVhbg0KPiA8c2hlbmxpY2h1YW5Adml2by5jb20+OyBK
aW5qaWUgUnVhbiA8cnVhbmppbmppZUBodWF3ZWkuY29tPjsgdS5rbGVpbmUtDQo+IGtvZW5pZ0Bi
YXlsaWJyZS5jb207IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEvM10gbXRkOiByYXduYW5kOiBjYWRlbmNlOiBzdXBwb3J0IGRlZmVycmVk
IHByb2INCj4gd2hlbiBETUEgaXMgbm90IHJlYWR5DQo+IA0KPiBIZWxsbywNCj4gDQo+ID4+ID4+
ID4gTXkgYXBvbG9naWVzIGZvciB0aGUgY29uZnVzaW9uLg0KPiA+PiA+PiA+IFNsYXZlIERNQSB0
ZXJtaW5vbG9neSB1c2VkIGluIGNhZGVuY2UgbmFuZCBjb250cm9sbGVyIGJpbmRpbmdzDQo+ID4+
ID4+ID4gYW5kIGRyaXZlciBpcyBpbmRlZWQgY29uZnVzaW5nLg0KPiA+PiA+PiA+DQo+ID4+ID4+
ID4gVG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24gaXQgaXMsDQo+ID4+ID4+ID4gMSAtIEV4dGVybmFs
IERNQSAoR2VuZXJpYyBETUEgY29udHJvbGxlcikuDQo+ID4+ID4+ID4NCj4gPj4gPj4gPiBOYW5k
IGNvbnRyb2xsZXIgSVAgZG8gbm90IGhhdmUgZW1iZWRkZWQgRE1BIGNvbnRyb2xsZXIgKDIgLQ0K
PiA+PiA+PiA+IHBlcmlwaGVyYWwNCj4gPj4gPj4gRE1BKS4NCj4gPj4gPj4gPg0KPiA+PiA+PiA+
IEZZUiwgaG93IGV4dGVybmFsIERNQSBpcyB1c2VkLg0KPiA+PiA+PiA+IGh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEzLjEvc291cmNlL2RyaXZlcnMvbXRkL25hbmQNCj4gPj4g
Pj4gPiAvcmENCj4gPj4gPj4gPiB3L2MNCj4gPj4gPj4gPiBhZGVuY2UtbmFuZC1jb250cm9sbGVy
LmMjTDE5NjINCj4gPj4gPj4NCj4gPj4gPj4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCBoYXZlIGEg
ZG1hcyBwcm9wZXJ0eSAoYW5kIHBlcmhhcHMgZG1hLW5hbWVzKSwNCj4gbm8/DQo+ID4+ID4+DQo+
ID4+ID4gTm8sIEkgYmVsaWV2ZS4NCj4gPj4gPiBDYWRlbmNlIE5BTkQgY29udHJvbGxlciBJUCBk
byBub3QgaGF2ZSBkZWRpY2F0ZWQgaGFuZHNoYWtlDQo+ID4+ID4gaW50ZXJmYWNlIHRvIGNvbm5l
Y3Qgd2l0aCBETUEgY29udHJvbGxlci4NCj4gPj4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIGRtYXMg
KGFuZCBkbWEtbmFtZXMpIGFyZSBvbmx5IHVzZWQgZm9yIHRoZQ0KPiA+PiA+IGRlZGljYXRlZCBo
YW5kc2hha2UgaW50ZXJmYWNlIGJldHdlZW4gcGVyaXBoZXJhbCBhbmQgdGhlIERNQQ0KPiBjb250
cm9sbGVyLg0KPiA+Pg0KPiA+PiBJIGRvbid0IHNlZSB3ZWxsIGhvdyB5b3UgY2FuIGRlZmVyIGlm
IHRoZXJlIGlzIG5vIHJlc291cmNlIHRvIGdyYWIuDQo+ID4+IEFuZCBpZiB0aGVyZSBpcyBhIHJl
c291cmNlIHRvIGdyYWIsIHdoeSBpcyBpdCBub3QgZGVzY3JpYmVkIGFueXdoZXJlPw0KPiA+Pg0K
PiA+DQo+ID4gU2luY2UgTkFORCBjb250cm9sbGVyIGRvIG5vdCBoYXZlIGhhbmRzaGFrZSBpbnRl
cmZhY2Ugd2l0aCBETUENCj4gY29udHJvbGxlci4NCj4gPiBEcml2ZXIgaXMgdXNpbmcgZXh0ZXJu
YWwgRE1BIGZvciBtZW1vcnktdG8tbWVtb3J5IGNvcHkuDQo+IA0KPiBJJ20gc29ycnkgeW91IGxv
c3QgbWUgYWdhaW4uIFdoYXQgZG8geW91IG1lYW4gaGFuZHNoYWtlPyBUaGVyZSBpcyBubw0KPiBy
ZXF1ZXN0IGxpbmU/IFRoZXJlIGlzIG5vIHdheSB0aGUgTkFORCBjb250cm9sbGVyIGNhbiB0cmln
Z2VyIERNQSB0cmFuc2ZlcnM/DQo+IA0KWWVzLCBJIG1lYW4gdGhlcmUgaXMgbm8gcmVxdWVzdCBs
aW5lLCBzbyB0aGVyZSBpcyBubyB3YXkgdGhlIE5BTkQgY29udHJvbGxlciBjYW4NCnRyaWdnZXIg
RE1BIHRyYW5zZmVyLg0KDQpTb3JyeSBJIHVzZWQgdGhlIHRlcm1pbm9sb2d5IGJhc2VkIG9uIFN5
bm9wc3lzIERlc2lnbldhcmUgQVhJIERNQSBDb250cm9sbGVyDQp0aGF0IGlzIHVzZWQgd2l0aCBB
Z2lsZXg1IFNvQ0ZQR0EgcGxhdGZvcm0uICANCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9s
aW51eC9ibG9iL3Y2LjE0LXJjMS9kcml2ZXJzL2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1w
bGF0Zm9ybS5jI0wxMzcyDQoNCj4gV2hhdCBkbyB5b3UgbWVhbiBtZW0tdG8tbWVtLCBob3cgaXMg
dGhpcyB1c2VmdWwgdG8gdGhlIGNvbnRyb2xsZXI/DQo+IA0KSSBtZWFuIHN5c3RlbSBtZW1vcnkg
dG8vZnJvbSBOQU5EIE1NSU8gcmVnaXN0ZXIgYWRkcmVzcyBmb3IgcGFnZQ0KIHJlYWQvd3JpdGUg
ZGF0YSB0cmFuc2Zlci4gDQoNCglyZWcgPSA8MHgxMGI4MDAwMCAweDEwMDAwPiwgDQoJCTwweDEw
ODQwMDAwIDB4MTAwMD47IDwtLS0gVGhpcyBNTUlPIGFkZHJlc3MgYmxvY2sNCglyZWctbmFtZXMg
PSAicmVnIiwgInNkbWEiOw0KDQo+ID4gWW91ciBwb2ludCBpcyBzaW5jZSB0aGUgZHJpdmVyIGlz
IHVzaW5nIGV4dGVybmFsIERNQSBhbmQgaXQgc2hvdWxkIGJlDQo+ID4gZGVzY3JpYmVkIGluIGJp
bmRpbmdzPw0KPiANCj4gWWVzLiBCdXQgbWF5YmUgSSBzdGlsbCBkb24ndCBnZXQgaXQgY29ycmVj
dGx5Lg0KPiANCmRtYXMgaXMgYW4gb3B0aW9uYWwgcHJvcGVydHkgaW4gY2FkZW5jZSBuYW5kIGNv
bnRyb2xsZXIgYmluZGluZ3MuIA0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvdjYuMTQtcmMxL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvY2RucyUy
Q2hwLW5mYy55YW1sI0wzNg0KRG9lcyBpdCBuZWVkIHRvIGNoYW5nZSB0byByZXF1aXJlZCBwcm9w
ZXJ0eSBpbiBiaW5kaW5ncz8gDQogDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55
IHN1Z2dlc3Rpb24vYWR2aXNlLg0KDQpUaGFua3MsDQpOaXJhdg0KDQoNCg==

