Return-Path: <stable+bounces-111098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927CA219C0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448B51619E7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3661A239F;
	Wed, 29 Jan 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+YxmmKf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5219E96D;
	Wed, 29 Jan 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142272; cv=fail; b=LwgirgS3JvpgF8YBU+B/MGvD4cDni2CwaWqY7Q0HaEcJziIW1Wh8b4L//1Fvk56SwOjKjLDtAWFhUF4Hh+UoTr0jdfZopljqcuQigNI8R9MzaxGZNxY4sZtbHj+5ed2Zer/OUJNeSWUp3i/KLgDfo1GgRQm++ro8rzqFl9EufAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142272; c=relaxed/simple;
	bh=2JmLA8yObJTGX6+TiznNQd0k0sJlJAn7Lc+OuCAtOTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VaNHyXX+164/466eRH6/FDZg7auL14w3KdowvQA0oRmXCkWumyRicKGcnwXbfWwaczfAfw9mPrQ97QrepYdscaWsRU9z1A7sknxb2h+g/jbu3iKaR8LO11pQ+Zx/Gj7z1T1+aU2x7E5L3GZGOpEiMQVoDd8z+sipbJ8UEpvWEhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+YxmmKf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738142270; x=1769678270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2JmLA8yObJTGX6+TiznNQd0k0sJlJAn7Lc+OuCAtOTQ=;
  b=i+YxmmKfzhXePYyjDNs1FEXVbkauywGEFHu3gOPI0ErPsRr7E3eIO2gM
   r1DV9BTd64QhE+PeLGAPD2omc9+SBpnDuh/NlNNnZpvSiMyGNAgPsTbek
   m1DNwNi8EVYGvzOQw567v2sRZGpCq0ZpSGjFnj7Wl31zFGTRIJzHkN+gh
   AnogECTE4xQNRSImJSUtj35iyXugUDFRBmbrHDgvsb1SvUeF1aH9Js3xw
   4izu2wqFo9abw8DV4REDn6SlOLNsgBV8K/KniT8fPe/G6BfgMGBKFLOdq
   8jc/BSGmBLlrQ8+o9Jy/o7ZJrPiALr3rTA6ppUaQ9M/Aa6hpEfXjAvHgu
   Q==;
X-CSE-ConnectionGUID: vXRGg93yRHafl5jFMQ55HA==
X-CSE-MsgGUID: +Zn+wgg0R7uLlVywNNRjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49629118"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="49629118"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 01:17:49 -0800
X-CSE-ConnectionGUID: 1z2OXHiHTSSF/tKAeg0izQ==
X-CSE-MsgGUID: YJw0U7cOTJ2ThkWi5NwLWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="113961316"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 01:17:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 01:17:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 01:17:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 01:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEKXIW1mAzCEkwQr1xhNSprw7o3Dju2gdWgy6EQzMIke0ALydIKWmEGrk9t+BqZs9yBbtdDhLpWyF6Y2xXBHsVcV5YvnxnAa1OfaMkiiQajcS1PbMGosVXESTlA1Ge3mth+wOdEPuSQwAq1iQ4Joxa4iUT6gj2n6rCLT4H3dNUb3efJHBL0apT3TAh8Y93bv8rlFXjpT4XmRW+/gZH3MJHFr76fBkjxHr7hxTWOSLIfwb0zwtE1/cUcxjH5/lW2KU8H0q+bahVsig3+OgOPusOBzPz6CYKQ0hAd48dTGZJQ0NftjIgA1oNsf1aN+Iwjxk3UxMIbkz0YvshVLQKsJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JmLA8yObJTGX6+TiznNQd0k0sJlJAn7Lc+OuCAtOTQ=;
 b=jyObtVDTgeiaWq3peQXCBWuatxjZH8Y8S1nU+4DZf6zjtd8cbmC3SmxJDpZ1VMzES3pJdUzP6aDCl73bE1C3NjLWCKRhh1gqBKgNy17YOovlgPoJIma8T/MvoUPll6plZ0luPxyypGmvqEqYzhA4qvDg8ZbaIK6uDoJYYlr+fdfif6lv4DdrxrGULwnN6yX/VhSPsIPl/EtIIbY6ykFWRMHoim6uylvpdCLZMrOGCqwgHLKfqIBDhKQ3TzTzMtVkkJllD2BD8lKhVNgak9eH8Q+GdWMPCkGr2pogBe7g0SkQKhp6pIgPxU+Tzxc4Kd0DN1ay33Z4f++1195YCt2tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 09:17:30 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 09:17:30 +0000
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
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQA=
Date: Wed, 29 Jan 2025 09:17:29 +0000
Message-ID: <BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
 <87plkgpk8k.fsf@bootlin.com>
In-Reply-To: <87plkgpk8k.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|CO1PR11MB4996:EE_
x-ms-office365-filtering-correlation-id: 6e047252-933d-4bd2-119c-08dd4045c18c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDdzU3A4ait0KzQrYldYYTR3L3d6alBGemxBdkZhN2VybFV0M1Q5b0lkaXF5?=
 =?utf-8?B?N2lvVlpORnFCTGRSZnFXbGowaHJPS1RqSDVETHJCZGdpKzY1SmlENDN4bzBa?=
 =?utf-8?B?VUU4RTB3VEYwY2lNbEVqMVptdHJ5WCsxWnQ5TEJhWkpLRER2VkFnbVNrVjZ1?=
 =?utf-8?B?TDdCS0VoU1lBZ1RadytaVnNpWGNTNDNyWFBjZkROdnpyTEI3N1R6QTJpbjlj?=
 =?utf-8?B?Wi9NajAydVFTVmJvUFlFQXNmeWkycHNWOFJrOTdqZUM1TWJ3c01tM1Z6K1ZS?=
 =?utf-8?B?Y3JYS2U1Yy8ySG44VDhlV1lBNEhhVEc3VWRDWGYwd0ZteGl1cjRObTduOUtN?=
 =?utf-8?B?QjExZVphOE56cVJGOG5RRGlHNGt1ZWluRUdjYjJtV1lwNzMyY08rT012UjBk?=
 =?utf-8?B?WGdVSVZCc0o2bHpGZURzbXQ2RGs5RFVVQnR0WnAzbVh1KzM3Mk81V2dQS0hF?=
 =?utf-8?B?a3dLMEE1Rlgzd3ovQXh5SDJpUDVQRm5EQXJ2emhLZCtUMEplWitESDF5cm1p?=
 =?utf-8?B?am83dEY1d1RTV2dPMVcxUmpXYlloMFNGMlFaUE0xTklnRFB4eCtIVTZjM1BB?=
 =?utf-8?B?UHZraDZUWlk5amU4cklkN1R3anZRVW1vR2RiMEkwd3BzWlpLTzNhRTltU0FR?=
 =?utf-8?B?dCtuWFpycUEvWkpIanVyOHFTRjB5YVFDcklqb2hvWnlmTDhqZ1VmTWJuSEoz?=
 =?utf-8?B?R3AxZnVhODRtTjNLZUtPcllXaDlrZWN4UDdIMXcySzFHQ25sTnkrbVM0am1I?=
 =?utf-8?B?VmdwdU0xbGF4M0hPaklFWmpISDVRK2F3WXpNSHM4b2paZFVBMGlqUC92aEMr?=
 =?utf-8?B?NnV4Wkl5VnVZM255cTFoU0JRbm9hOVh6ZjM4ZFE0OEtlL0RXdGFyclFtRDZF?=
 =?utf-8?B?MWk3ZnBrV04zQjFITEdBTGw0VXNIdE9DOURUTm1tcHRWeWR0ajZZVFFsM1RY?=
 =?utf-8?B?YldUVUpwWmJTNGdEcUJac2N5WFEyNDhmTHRtSkQzNzk3WUZzdWg5SVlSVDNV?=
 =?utf-8?B?cUE3R3NybXBPVk5Kdzlkd3JGUVNHYVdtem9JY1Y3b01HakxudUpNclFQK3ZL?=
 =?utf-8?B?SXJYL2lHR0ZwRDB1b2djTGJSVHA2TXdMRndtcStWRVpUYmhjV1B0OE12NWZu?=
 =?utf-8?B?RmZiWEVScFFGdGUzMWszSzNGbmNxdG1SSS9PbVFKR3B1VnVXWi9SUmpkSTd6?=
 =?utf-8?B?Y2pxUm5IVTB6YmtuSVlQSCtDNzk2OTdlYUtCNWpCODVrU1V1UC9mWks1MHBa?=
 =?utf-8?B?WlpkUzg3b2JOR0JEWmMvZHBOaUFjSWkyemt0V1d2bmo0WS9zS29sWTc0dEYx?=
 =?utf-8?B?cHJWMitSRGdxbVRXSnEydFMrTXNOUFlYL1Q1SUlyVlk1OGNGb3VIK2s5eWtI?=
 =?utf-8?B?c2p6NTFrSWVrQXZiOGxzcHlwTThmdElObFRBSnFqK3padzV1R3JBL0hlam5i?=
 =?utf-8?B?VXZMalFROEl2RVdDVTVPNmFsSjM5dkdVVEY2bGRMNWFBczZYUzNha2ljTDNZ?=
 =?utf-8?B?RlVJbmdLeXhJQnhZbkdqaHNlVEJZUEkvb2MvdWNVU3dSZnByQXd6NmR3NGVl?=
 =?utf-8?B?V0hmQ2xKQ09UT3JSekg1bHgwa2M0WGVJUEp5YjloM25KN2htMEY0OEVPL09P?=
 =?utf-8?B?R3J1S0FTNXVtanpadnc3bkNRVDVEY3NzWCtMSVpRNzRzYzNiQ1FWTmxNeWE3?=
 =?utf-8?B?WmtibWFpMDdPVVBMeDFRQWJKbW1Ib0w1dXNSMFl1a3JYR1BqVFMvNmVXYS8r?=
 =?utf-8?B?QkVibTJGY3N4clJhbGZvVHNpanpjbFdOcFJ3SEpWZmNyZWp1L1hvOWNPMHBE?=
 =?utf-8?B?TDFwdCtBQzhwMlNPU0RxMDZKc20rN1FTVVVtUDZDbWxtaXFpZUFFVFR0MVh3?=
 =?utf-8?B?ejhkR3FJZmdpUVZTZm9tS3hGN2dVM25mdDB2TUtKaWRzeHVMZ2gyZXZpcG5j?=
 =?utf-8?Q?igG3fxkl/TnQhXdZED7Sfj8iP/MmT6IF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhaTm1PUnRndzlkM01HL3lHUFRObERGVDQ0VlB2TjVpajl2c3NSQW10cjlv?=
 =?utf-8?B?dVBKRXh2RlpMN2ZpSW1YUHZBdHp3WG41bU9YU0k2a3ZaVHBieW8wdjFuMDU0?=
 =?utf-8?B?c0c0VlVzeDJvOTBydVJ2YllNckVHbklVVWJzNzNjWmhtaHZjcUZreWtTRHBm?=
 =?utf-8?B?ODJVZ1lXc3EzUzFDTkM4Q1MvOFhDanlLWW8yeUVIRmtWZzlMbVVHcGVvT2sv?=
 =?utf-8?B?NFAxbzFERUk1Z0Y0bWtta2lqN2FodE5EcExrcTZyS1I0a1Y5Rko3bURQZEJ2?=
 =?utf-8?B?bEZZSjkrOGZDUjhMRjBLZ2o5SVNxNTNCZmlaVE5PWkNLank3NkJreUNLaTFT?=
 =?utf-8?B?QjBLaWo4dG16ZC95VEZzTkdFTFN5Qno2NDJ5b2lvWFg4RE9FaFFnMjg5Z3R3?=
 =?utf-8?B?SjZaaWdqRW5CcGdtSFZKT2hWSlQ4eFZsYW1BdEJMQ1pOV2VOOEhSc3Uyb09i?=
 =?utf-8?B?SVZqaWM1Q2cxT25naC9IVjJmNlVoZW1lZDFYZTV4d0RHaGNGbHh1VmQwcEQ3?=
 =?utf-8?B?T2J1U29EUUF5Nk1MaVlmT2JuQ2VPamFacUdaYURveTJWYXJWUUVIU09iN1Ez?=
 =?utf-8?B?VjhnN1FyZE9ZVjdwclBrZ2o1Q3JYYWFScTRPOElZVFl3M1J6L1gxOGp4eHl1?=
 =?utf-8?B?WmY5UHpZdkR4a3F0TGNoM25kbnJmVUovQnpjcUN6Q0Jvc2JIOW9kci8yS0FT?=
 =?utf-8?B?WDBsQkVnZDFSZWJHSTlYUVZMNnptV2RTbU1EWmdiWExzdHVWOTVnY0ZJQ1NL?=
 =?utf-8?B?eVI1R3crQlRZY0o1NUdUQ2ZUZlJmRlhzbzB2ZklDWjd4SDl5UDRmRjJjbkVt?=
 =?utf-8?B?eHFlcFZ6bER3NnN4dFlUa1BvL2JIVjJoeG0zdGFvd2xPZjVJRWI4L0VieFlp?=
 =?utf-8?B?TVpRb0w1c0M0R1Y2eWRMRE1ZcWt4d1dCQlhhMDRkVXNnaEFPdVBFbFpVQ3pI?=
 =?utf-8?B?bmZiQy95ckJWc1BVbDV6bGlWOERIRnpZb01Ga0o3Qm1TLzNmY1gwU21lbmMr?=
 =?utf-8?B?YnV6ZmFhT3NTV2ZZTUpPUHh3U2ZZVjZUeTVIaE9ZRGp2aXg0TmFteGVnanEr?=
 =?utf-8?B?dENHakQ4d0Z5V3BWWU5QZ0FNVThoRG4zNjcrZzFPZkZXZFdpSmlhbkJoclpC?=
 =?utf-8?B?WXlBKyswWTBmTVUxQ3lMMy9iNlZjaGtuMDRweWhQQVBoTFJCa3o4OFlBYzRw?=
 =?utf-8?B?RU85NmZWOEJLV3Job2UvblVOUWRVblZxQmhIZWc1Q00wZHNpcFIrenh3eDZp?=
 =?utf-8?B?VzMyVEpORENON0RoMVJNdTgxR3Y1WTdkalFvWTkrRTMrVnR3WjJQVk5VNjE1?=
 =?utf-8?B?ZzRPTDgyUytYRE1JZ1VrUGpTcWdYUU93STZvbHpkQ0pCaFhQWXM0WkR5YkdS?=
 =?utf-8?B?VDA0U0dsVWhQS3RGU0ZBTUxhallodXBwSkFJZTRhTkhqUTZVY1NGcWVhUFk1?=
 =?utf-8?B?Q0hVWUhFRmIxcDVSS0hsTUVacE9iVThucUd5dFNNRVhKNGFiYWpwSUtNeXhi?=
 =?utf-8?B?TDR2ZkxsdllKcDB0Uk9MVzU0SDFWWFBNb3F6WVl4YTdzNytMdnR2aTUxV1hZ?=
 =?utf-8?B?ZVlXajdHNkx6UEt1cmpWRlRyK2kwSTN0Z0gvdzkyeVZPQ2FsZmpUUXVKUW9V?=
 =?utf-8?B?TGJZdGUyVThZK1BqRG4zMkdnNWR3TUtYZnl2NDFEa0x5U09JN1QxYmFlNktq?=
 =?utf-8?B?c0ptMHFXNjBzWWVBRll2U1JPcHVDb3d3a25TYnNCaVU3d3l1QVdBc2ZZRTla?=
 =?utf-8?B?dnVHai9NL3RGbXp3QkN2U0hORW1Da0FvQjBxUTd4SnNXb0wyeDlvL3VzUTJX?=
 =?utf-8?B?dzRTdEY5aVdrRXdrUDhreVRuYUdZMHcrMmNUc0xHVC8zMEpYaVBudFhDazVZ?=
 =?utf-8?B?aGhab1FQenFOTEV4U1N4Wm50RGM2NFpvdlRIQUxndzdtVVB3aHE0QTR0RnRQ?=
 =?utf-8?B?Ulc0YmlWeDYxV2tNWnJScXFuZlI4M04rcFVKYnRaOWpFODRJNXFoTTNic0o2?=
 =?utf-8?B?NFdKWGRLNmRlRjB2VzdPMmlkUC9FTW9xbFlCMm9SZnRVSkZUa1VzS0dSZ0hT?=
 =?utf-8?B?TFVueTFjMnZJWWZDTVFpWmYvaFdYMk0vM3NNVHRJQWVlSnlPLzd1c0hiTjJk?=
 =?utf-8?B?Mlo5dXR6Wml6WEtucEUwaUN4MTh2c2N1UXRLaU9nb0t3VTNRc1RSc0IxVW1B?=
 =?utf-8?B?MnVwZUNNeUZHY0JleiswMjhrSEZISXFCdVNkS2gwQ2pJbzZrYjFoSUppbndS?=
 =?utf-8?B?SitYanZmL1VrbTJsYUJhaW04c1FRPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e047252-933d-4bd2-119c-08dd4045c18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 09:17:29.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNcyeh2HXaYxxzOx+vI5rP1FSePT0kk8miYxITgQY676MSQhfgI+e4fSw1JMpBXgom9xoWyizRvjAFTV7C2L6MosrHdcg3AO2998il1NMBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com

SGkgTWlxdcOobCwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
cXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IDIxIEphbnVhcnksIDIwMjUgNTo1MiBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5p
cmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxy
aWNoYXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47
IGxpbnV4QHRyZWJsaWcub3JnOyBTaGVuIExpY2h1YW4gPHNoZW5saWNodWFuQHZpdm8uY29tPjsN
Cj4gSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IHUua2xlaW5lLWtvZW5pZ0Bi
YXlsaWJyZS5jb207IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEvM10gbXRkOiByYXduYW5kOiBjYWRlbmNlOiBzdXBwb3J0IGRlZmVycmVk
IHByb2Igd2hlbg0KPiBETUEgaXMgbm90IHJlYWR5DQo+IA0KPiANCj4gVHlwbyAocHJvYikgaW4g
dGhlIHRpdGxlLg0KPiANCj4gPiBGcm9tOiBOaXJhdmt1bWFyIEwgUmFiYXJhIDxuaXJhdmt1bWFy
LmwucmFiYXJhQGludGVsLmNvbT4NCj4gPg0KPiA+IFVzZSBkZWZlcnJlZCBkcml2ZXIgcHJvYmUg
aW4gY2FzZSB0aGUgRE1BIGRyaXZlciBpcyBub3QgcHJvYmVkLg0KPiANCj4gT25seSBkZXZpY2Vz
IGFyZSBwcm9iZWQsIG5vdCBkcml2ZXJzLg0KDQpJIHdpbGwgZml4IHRoZSB0aXRsZSBhbmQgY29t
bWl0IG1lc3NhZ2UgaW4gdjMuDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2Nh
ZGVuY2UtbmFuZC1jb250cm9sbGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9j
YWRlbmNlLW5hbmQtY29udHJvbGxlci5jDQo+ID4gQEAgLTI5MDgsNyArMjkwOCw3IEBAIHN0YXRp
YyBpbnQgY2FkZW5jZV9uYW5kX2luaXQoc3RydWN0IGNkbnNfbmFuZF9jdHJsDQo+ICpjZG5zX2N0
cmwpDQo+ID4gIAkJaWYgKCFjZG5zX2N0cmwtPmRtYWMpIHsNCj4gPiAgCQkJZGV2X2VycihjZG5z
X2N0cmwtPmRldiwNCj4gPiAgCQkJCSJVbmFibGUgdG8gZ2V0IGEgRE1BIGNoYW5uZWxcbiIpOw0K
PiA+IC0JCQlyZXQgPSAtRUJVU1k7DQo+ID4gKwkJCXJldCA9IC1FUFJPQkVfREVGRVI7DQo+IA0K
PiBEb2VzIGl0IHdvcmsgaWYgdGhlcmUgaXMgbm8gRE1BIGNoYW5uZWwgcHJvdmlkZWQ/IFRoZSBi
aW5kaW5ncyBkbyBub3QgbWVudGlvbg0KPiBETUEgY2hhbm5lbHMgYXMgbWFuZGF0b3J5Lg0KPiAN
Cg0KVGhlIHdheSBDYWRlbmNlIE5BTkQgY29udHJvbGxlciBkcml2ZXIgaXMgd3JpdHRlbiBpbiBz
dWNoIGEgd2F5IHRoYXQgaXQgdXNlcyANCmhhc19kbWE9MSBhcyBoYXJkY29kZWQgdmFsdWUsIGlu
ZGljYXRpbmcgdGhhdCBzbGF2ZSBETUEgaW50ZXJmYWNlIGlzIGNvbm5lY3RlZA0KdG8gRE1BIGVu
Z2luZS4gSG93ZXZlciwgaXQgZG9lcyBub3QgdXRpbGl6ZSB0aGUgZGVkaWNhdGVkIERNQSBjaGFu
bmVsIGluZm9ybWF0aW9uDQpmcm9tIHRoZSBkZXZpY2UgdHJlZS4NCg0KRHJpdmVyIHdvcmtzIHdp
dGhvdXQgZXh0ZXJuYWwgRE1BIGludGVyZmFjZSBpLmUuIGhhc19kbWE9MC4gDQpIb3dldmVyIGN1
cnJlbnQgZHJpdmVyIGRvZXMgbm90IGhhdmUgYSBtZWNoYW5pc20gdG8gY29uZmlndXJlIGl0IGZy
b20gZGV2aWNlIHRyZWUuIA0KDQo+IEFsc28sIHdvdWxkbid0IGl0IGJlIG1vcmUgcGxlYXNhbnQg
dG8gdXNlIGFub3RoZXIgaGVscGVyIGZyb20gdGhlIERNQSBjb3JlDQo+IHRoYXQgcmV0dXJucyBh
IHByb3BlciByZXR1cm4gY29kZT8gU28gd2Ugbm93IHdoaWNoIG9uZSBhbW9uZyAtRUJVU1ksIC0N
Cj4gRU5PREVWIG9yIC1FUFJPQkVfREVGRVIgd2UgZ2V0Pw0KPiANCg0KQWdyZWUuDQpJIHdpbGwg
Y2hhbmdlIHRvICJkbWFfcmVxdWVzdF9jaGFuX2J5X21hc2siIGluc3RlYWQgb2YgImRtYV9yZXF1
ZXN0X2NoYW5uZWwgIg0Kc28gaXQgY2FuIHJldHVybiBhIHByb3BlciBlcnJvciBjb2RlLiANCiAg
DQoJCWNkbnNfY3RybC0+ZG1hYyA9IGRtYV9yZXF1ZXN0X2NoYW5fYnlfbWFzaygmbWFzayk7DQoJ
CWlmIChJU19FUlIoY2Ruc19jdHJsLT5kbWFjKSkgew0KCQkJcmV0ID0gUFRSX0VSUihjZG5zX2N0
cmwtPmRtYWMpOw0KCQkJaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KCQkJCWRldl9lcnIoY2Ru
c19jdHJsLT5kZXYsDQoJCQkJCSJGYWlsZWQgdG8gZ2V0IGEgRE1BIGNoYW5uZWw6JWRcbiIscmV0
KTsNCgkJCWdvdG8gZGlzYWJsZV9pcnE7DQoJCX0NCg0KSXMgdGhpcyByZWFzb25hYmxlPyANCg0K
VGhhbmtzLA0KTmlyYXYNCg==

