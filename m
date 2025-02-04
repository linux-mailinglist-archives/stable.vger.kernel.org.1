Return-Path: <stable+bounces-112173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC7A27429
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542371883994
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF62212D7F;
	Tue,  4 Feb 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOCuFuma"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36747212D6F;
	Tue,  4 Feb 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678284; cv=fail; b=RkAbtDjjp1kJWNBLUjWOweTJvzR6M3uCw7o5ORtulQFI48ul8VoIfU7Pbq2iyYhNb5pQnnKzJ1Tp98aa+7VizofGcPLd4FXG0rO+U28ysNkzgr7WIadLqvaA5RGsJ7hyUQv24cSKegdnHM7rwyheFfCSs+LV6WYZTB6DYnmCqhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678284; c=relaxed/simple;
	bh=t9JlUcExKv9LP9BaeYHDQfSxKS2cnO8KJ4vLD/3CSvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ccGl3KvhzPjrlgAncO0jXa5bEHZLlsbz7pqyDvICSVnCwoQQchReOGksS4ZQPk3NlbWiMnlmoEkH7PU3D8ZXyGnoB4QxE+K3OZaD5ruADEhVbsvCpCz2DqxZOm/tR5GwfRLkhDNrT931qH9MqLu/DISOa0tA9G4pUhN2nA52+Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOCuFuma; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738678282; x=1770214282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9JlUcExKv9LP9BaeYHDQfSxKS2cnO8KJ4vLD/3CSvo=;
  b=LOCuFuma3CJtmo0NF/oAAVue7E0tXOJvVMZWNcBrJpUJIz+KxEzbXCMP
   Guxhr05bYzVHcg/7kZRC1qTPewdl8ON7BQeKW3PcIMYtxykbu9tr4PcHN
   0QhH6j/+7M29/ENhf8Q114SL73uyyADnAnDiWXPe8VzHGH4sr0Tgq7s2p
   UADvpR8LtSp7rITc6fPVeIKPcyfQoukgWuUltqxLz9OrExr1ZVi7X7XbW
   23/o+o5XTmUxKX3PBZfnPCE154s8XB/9d1OmNUknge8rRzIT0VtJ21QY4
   dXXybLjsTuMXAjlOkNuGO14IdDKsovndp/9KB7Sz1vbZZsLoPQnMjEz/6
   g==;
X-CSE-ConnectionGUID: wqolyXudR+WMcIzNGsqzQA==
X-CSE-MsgGUID: maIL1j5MSTuRpjE1RWpb9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50595775"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="50595775"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:11:21 -0800
X-CSE-ConnectionGUID: XQ4k94uRTKWPd0oV1mtW3w==
X-CSE-MsgGUID: idNR/Nc6RbSMTT91K98s1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="111148924"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 06:11:21 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 06:11:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 06:11:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 06:11:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5qXyOJNTrYWBLwQ9lKdRZRsrCszv8mt6wskkx3JAIKcyl7QrHNXtOjJXnfUeXMDgVQlTbZDNilF+032vplKQA5LgS+zmdT85nCUk81wqDpbc7OfbtDsU56EUiS+Knop+N9LVq9armElriOox4x5UjQ+m8mgphEMOKnC2kQSmwxKYdeaVeTr8PoYW2zECPldxBTZ63hjd8j8EpQQUCigsXn9VxOpD9/MaYXvSPlmW4IAi2iUr/ExP6lcWVMCHHMCD3RX5IfBFJQDc9IqL5SGy9I9j7ows6QN/XF8Vc3quaYcNN//994TtIVtVS2MAiOb5sK+/XNcSq23rCNanIbsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9JlUcExKv9LP9BaeYHDQfSxKS2cnO8KJ4vLD/3CSvo=;
 b=WclN4XM/Dc75SPCbA52MSuJ7mNi5xcrMVlwCVGnppKaUNIkUO0dvyPrr+va2jgen1+QQW9k/9MZs2MuNicpFd+ElzeeO9uwxB/Vzbibjahb8As2+45s6J97K2sv/YFmONoRns8AfrpJxTj4nOX0JtP4actcO+1W3tql1SlNzUvtwxNCJMeUJzBIVOkgJiQC/R/pYn+BH7hUUVblCXR0tgDc6jClTJFuv2AVbyGLnNYhUCERMgIbpWUp3P3Rw06RzAHxVSbeV98qS/1qeCimmkmcfv2TO8Tal23/hE5s1dnq+9vVi4wtvuU8FJQb0gBwmXl8CYxeIqTnH1t5gt4cSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 4 Feb
 2025 14:11:16 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 14:11:16 +0000
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
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQCAA0UcDoAA++LggADu3AKAB1OZ0IAAI5krgAAWHVCAADB9joAAB7yw
Date: Tue, 4 Feb 2025 14:11:16 +0000
Message-ID: <BL3PR11MB653239DDBD9D8E7D413B60F4A2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
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
In-Reply-To: <87frkt96nw.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|CY8PR11MB6865:EE_
x-ms-office365-filtering-correlation-id: 68a2e8d1-aa5c-4c00-39bd-08dd4525ca65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3YyeVk3WlRIZytaeFcvMStmeHNDTkpkSUMyQU96d2gvRkRKRVRRSlptU2E1?=
 =?utf-8?B?NElXeXZRSE1LaFBCa3dubzFTM3pEZ3lBUzVqUGk2RTd3cHBpWlpOLzRaaUF5?=
 =?utf-8?B?UVM2YWtTVVhySXR1M0lUc2J3MnJiam1kaEkxZ0VZTmxXZW5wL2JSUDNEc29w?=
 =?utf-8?B?cGtqc3NRQmJUaEhydGxnWXlDSnRWMnRSZ1crejYyYWpXYzBLbUNtR3VZYUpX?=
 =?utf-8?B?MEtKQUUwRjl6cDdTNmd5aUUydTYwY1RSYWl0Rkx2M3owYjMwY3o1WkJodmNv?=
 =?utf-8?B?YThlTXZHR1d2eHpodlZCbHVOcGswbFhQZ00xTHRYK3lsVHNEQUc1SlErTGpo?=
 =?utf-8?B?TkY2YTJ1akJRMzZDTWVsdUZva0JtWHpSb1hZNHcrSlI1T0tMUVNqMXVqNnE5?=
 =?utf-8?B?TkhHMUJYdnZud0F2UkNWaU5BcUhodGNtMTkwL3V6T2NaNnJnUUNkMzVRNFRK?=
 =?utf-8?B?Rklsbkx1ZFRxM3NzZnUzKzR3cU5BTWNaQnk2TWFZR3RWZ0FHKzF4RjVDRjBL?=
 =?utf-8?B?V1VoRVpFUUZBOXBSVklyUXkwYk10bWdpcnVuN01TYkdiVUVZWjJtcEdCQUxr?=
 =?utf-8?B?K2gwc0c3NEExeEpjTTU3Nm5teW5EMi9laHhhMXYybElEWXgzY3dPOVk4cWlV?=
 =?utf-8?B?ekNNLzlwSU9RTFlFREM1clgyQU4wUW5HWEtyNTF6NDBpZGJpWCt2SHM3Ni9E?=
 =?utf-8?B?THEzS2Y2ekNvVGNvclhUTittWk02VEJkcVREdUlXUDJXQ2tzWmVOTDNtRDlG?=
 =?utf-8?B?aDdqSHJXd2FzeGhoTFo0d3NNejFNc0IyTS9hQ3V2NHNtN3FNYzdEdzNtRVgy?=
 =?utf-8?B?Nm8zaTk2TkUrV09EaHpVM1luTVhqb2Z0aktvQXdHYUVBc014VnNXL2p3R0tp?=
 =?utf-8?B?SWFhTDZyTWVtTTVXYnlKTzhPbXNHY2E5Sk84YW9zWWFPaitxdFd6ZmVySjMx?=
 =?utf-8?B?cjR4Y1hvK3IzWm53eW1lajYzS0hxb0hiNG9ZWWw5TEp2RnNnSGprSzlaQ2FL?=
 =?utf-8?B?WlkwbVJnWEJENXBVdmNaejRVSHM0cmtHRUZmZkNFbzNudWY4YjRFT2RudkR6?=
 =?utf-8?B?UXRXUFlFK0NZK0h0d0ZPYXY1S1dZSFFUc1ZUbUc1M2E1QmhWMHYwMk11OW1T?=
 =?utf-8?B?M2tDMHBvdEljZXczMzkyamt4aWg1UXNWb3dFVUt6QW10bFBFd3dSRVRVYjFY?=
 =?utf-8?B?c0tmeU5ZZDg3U0RycHVLbXhZUHdwTHZvREtVaVRVeFRlNGRySHdYeGkyQkRr?=
 =?utf-8?B?dktZc1BIenl2WWM3RHMvamNzN0JyVHJzVXp4eWsyMVg2RDVJZkxBa1lEY0RB?=
 =?utf-8?B?aHJ0ejZFYjhLQzlLbzMxdjlEanEzZHNlOE1TTTBGMWJEbW5TU0dEdExINXlJ?=
 =?utf-8?B?Y2k4VlZDOGRmOTNJZDNzR1BQbStwRWZRRzJxMEZVTnc0MWdkZW9EaHRyN09t?=
 =?utf-8?B?M09GbFUrcVVPTlp0QzBwSW1SZFNaT0pXV21OanhGeWM1ZXRLK0FOTFhvUFJv?=
 =?utf-8?B?YXQ4UHg5MzRFNmhJL3Z5c2NwZkJEdGY2VDlTSlZ5TEExYmNjSHVNdEN4b3gy?=
 =?utf-8?B?bUV3ZGhOUFV3dHMxQjJMSEtYRkNNM0VVVnI0UjM0bEVhSlkxRUl2ZGkvQkx2?=
 =?utf-8?B?V256MEx3MW05c2lvRXUxTUYyR05zV3lWMnlwU3pSaWp6ZGc2aHhhN3JHbFBG?=
 =?utf-8?B?RCtFVEExanorbWZzVmRsS1VBekVNVnp0bGt0ODdyOEEzMjJJMWgvYnhrZ0gr?=
 =?utf-8?B?OElqYXRVQWlWTzBCNWw2NjBiRXFEZGRGNUU1NWJWYXVwTWt0U3ZqTzh1TitU?=
 =?utf-8?B?ZkM4dkRFaVRJM2pzS0Rrd3VVVkdLa3V6OEhUOVZmWjZRYm5pSGRBWVRNODcx?=
 =?utf-8?Q?US6Tolx4Y4ek4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1GZ0dmY0xqQk4zOGk2dFdEUDlUa1g5Vzg3ZmhxZE9iaXpYRk01RG5ZNEFw?=
 =?utf-8?B?YWp6WDJaOVRzM3J2LzQ0NEU2SGZXL01PRHBBTHNLZEdsTmpTMjBDM3U1L3Nz?=
 =?utf-8?B?dGF4VHVwaENNU0dpNTd6NTJrZkVzMWZUcU1EREIvakpaWGJXUk1xNnlmeGJz?=
 =?utf-8?B?dVVWTGJWUlFmZTk3Y2xaQ1JYNkVSR1lHYUFWcGRyb3dNN0dwSUVoZzYwanBj?=
 =?utf-8?B?dUo0NmQzclF1NVpRdmQrbXNLSVFHTE1WWXFFbS9HOFlIU1JSd0Nxb1Q4QnhL?=
 =?utf-8?B?OVpkbkdZUFBMV1ZRM251T2lvMUlPYzQ4TlRDdm95Y1RiSGNJRmN4dUZnRXNp?=
 =?utf-8?B?cTNpOUVmL25EWCtESHpiZG53VUU5ZU5FTHNseFp0bTkzK2crQ3NFU1c1SGVU?=
 =?utf-8?B?OEJkUmdBek1zR2lkMDNMQ0ZGdFp5OG5xUWVPcWtBVWExUjNnTHQvN1dJK0lI?=
 =?utf-8?B?Qk9zU3VNc3U1eUpuQnNaektvb2dybjJZYi9kNTYvNmxrTnZNc2wzMjRzNGIw?=
 =?utf-8?B?SU9nR1FLbUtXNENpQUdzTDNrcFQ3RkFQMUl3bTRLTmtkWDR0WlJ6d1FYYXJo?=
 =?utf-8?B?cTdUTHNuNENsNWpPWFI3ZS9TUTFFelNEeFlCMHJnMjZKQmphVEo5UTVuRk1t?=
 =?utf-8?B?bWhFTkVKQ1NrUVJnUTBoWi9sMFVDZUQ0QVVDaGhybnVXcm1MaEhoUTU4NFNr?=
 =?utf-8?B?RzI0OVRnZ29ZbUVsMzdtM0RlZVM2WGZGaHlXVWZJVEJpOENtemN1U0lLVmo3?=
 =?utf-8?B?QllkV044eUFSeUlZU2NVb21mc3BPSG1QM1UwL1BJaFoxTnUwaWdaR3NoTERo?=
 =?utf-8?B?ZCtlUXFQbXpaVHd6Y1dkcTlrUTlOckFKcVdQanpXbGJWdE9YYnRmczVPWlRw?=
 =?utf-8?B?NjlDT2w5K0E4U0htY0RidHF0U2NzdEpKNW1XcGpGejhsMjJwUExmU1o4RTRl?=
 =?utf-8?B?WDlvdWhEN0NzMnZ0M3UwMTdUM2gxVCtGS2k2ZzhGMGRMdzF2ZHF6bjQwcUFC?=
 =?utf-8?B?dDFKZ1crWGp6cW1QbjBHemppKzBwVHJ5VnVPaXRHUmVTcXVxbDN6RXlvejE5?=
 =?utf-8?B?NGJzcTZUSEtDeEQyRW50K0JhQzMrWUZQUTBoeGVJcHlLbGl5VGlvMGVGY2RJ?=
 =?utf-8?B?R1RjdSsvUU5RTjNuSGMrZVlFekVRRDdYOGk0ZWhieXZnZWZQRm5RUlF3MUtT?=
 =?utf-8?B?VHd3cG1hU0MyaVlLRjNOMUtSaXhkVkd4Z1RNUjdPQlZRc011WUZWUTlrdjJI?=
 =?utf-8?B?dlJwV3hZSjA5WjhSNEJZTHdEVmwrcmdWV2hlMFNLZVgzZUZGdHlMSE00UEp5?=
 =?utf-8?B?S0orSGVRdzJhUzNGOWJValFjd051WC80MWxwYncvdWZwck1QZTVhT1JyYzFi?=
 =?utf-8?B?QWRjWmQ3bmVzb2JVYldPc3FkeUZvTml0NHo0R0lBMW1lOGtmbzhkR0tDVE9t?=
 =?utf-8?B?WStGc3B2dkZDbmNIc0FLa0lzNlF2SDZTeFlCTUd1TGpvclg5bUdyQTZBa2Ey?=
 =?utf-8?B?QjFlSVl1Qis5TVo3MERZY3d3dlBzdk4xdnA2aDhvN0xqdGRYTzJ4c3oyYTIy?=
 =?utf-8?B?RzNXV2pMSldmQ08zSmpicXhsdGNUMi83dklkbUIxWlpnYWpCSlF3WlNxOUtk?=
 =?utf-8?B?eDlIUG1jeFY1cUxVVjQ0akJpVGtCVHlBMHZJdVJuSG5WbTQrVDlXQUMyUlhS?=
 =?utf-8?B?NDk3TmJYY2ZJcEpZWUVVaG5Xb3czWUVtZ010SktWcVVLTGROVjZQNjBJaWYx?=
 =?utf-8?B?ZkN3OEpnakxoVG5iRERKMDlUWHJQbHJkUFFaaFRlYk0zMjNoQjNQaFJzNzh5?=
 =?utf-8?B?NUxKZ3BiN2lMdlduL2JpeDBGOHIyUEk0c2wrS2lXTnh2SnhvNEVyeE14bytT?=
 =?utf-8?B?Mm5sV0NRRkJIYmFBeDQ1SjJSeTg0eHFQaC9sU0tZUXp2ZmxBQkxwSEtTTTFj?=
 =?utf-8?B?UUV3bGJ2a21BT09RMkJlS2ZaQnNkSVhod3lrNDFRMFp4dEMyTlN0dVE2SC91?=
 =?utf-8?B?Sk1kUVZFZjBuTGZFNUY1ZXZvUEkxSVlpbk94L1lZclRubUM1SnlLdXZmYXNE?=
 =?utf-8?B?a0FVbzJCcUlhVTF2aUhEL3drQUJLNk4rNFdteFpXYWE3SDhSV3ViaENlZVY2?=
 =?utf-8?B?TkFWNkJ5VFVVcFdrSkM5Y21Td0NjVFlkaEtmYnZQdmN2dzRzRmIxc0dzbUwr?=
 =?utf-8?B?clE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a2e8d1-aa5c-4c00-39bd-08dd4525ca65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 14:11:16.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwQbTPT/6Vbpv216DMVO6TgFeDNSSRIcU6v+uy8ZhXjlnB+NLkSBuiV/YkXXaEZ6e+6U205yqMW6EMX4Tg3ZmBbOsxP/SuNgjCKAZbv3zOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDQg
RmVicnVhcnksIDIwMjUgOTozMyBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2
a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IGxp
bnV4QHRyZWJsaWcub3JnOyBTaGVuIExpY2h1YW4gPHNoZW5saWNodWFuQHZpdm8uY29tPjsNCj4g
SmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IHUua2xlaW5lLWtvZW5pZ0BiYXls
aWJyZS5jb207IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDEvM10gbXRkOiByYXduYW5kOiBjYWRlbmNlOiBzdXBwb3J0IGRlZmVycmVkIHBy
b2Igd2hlbg0KPiBETUEgaXMgbm90IHJlYWR5DQo+IA0KPiBPbiAwNC8wMi8yMDI1IGF0IDEwOjQz
OjIwIEdNVCwgIlJhYmFyYSwgTmlyYXZrdW1hciBMIg0KPiA8bmlyYXZrdW1hci5sLnJhYmFyYUBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+PiBIZWxsbywNCj4gPj4NCj4gPj4gPiBNeSBhcG9sb2dpZXMg
Zm9yIHRoZSBjb25mdXNpb24uDQo+ID4+ID4gU2xhdmUgRE1BIHRlcm1pbm9sb2d5IHVzZWQgaW4g
Y2FkZW5jZSBuYW5kIGNvbnRyb2xsZXIgYmluZGluZ3MgYW5kDQo+ID4+ID4gZHJpdmVyIGlzIGlu
ZGVlZCBjb25mdXNpbmcuDQo+ID4+ID4NCj4gPj4gPiBUbyBhbnN3ZXIgeW91ciBxdWVzdGlvbiBp
dCBpcywNCj4gPj4gPiAxIC0gRXh0ZXJuYWwgRE1BIChHZW5lcmljIERNQSBjb250cm9sbGVyKS4N
Cj4gPj4gPg0KPiA+PiA+IE5hbmQgY29udHJvbGxlciBJUCBkbyBub3QgaGF2ZSBlbWJlZGRlZCBE
TUEgY29udHJvbGxlciAoMiAtDQo+ID4+ID4gcGVyaXBoZXJhbA0KPiA+PiBETUEpLg0KPiA+PiA+
DQo+ID4+ID4gRllSLCBob3cgZXh0ZXJuYWwgRE1BIGlzIHVzZWQuDQo+ID4+ID4gaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTMuMS9zb3VyY2UvZHJpdmVycy9tdGQvbmFuZC9y
YQ0KPiA+PiA+IHcvYw0KPiA+PiA+IGFkZW5jZS1uYW5kLWNvbnRyb2xsZXIuYyNMMTk2Mg0KPiA+
Pg0KPiA+PiBJbiB0aGlzIGNhc2Ugd2Ugc2hvdWxkIGhhdmUgYSBkbWFzIHByb3BlcnR5IChhbmQg
cGVyaGFwcyBkbWEtbmFtZXMpLCBubz8NCj4gPj4NCj4gPiBObywgSSBiZWxpZXZlLg0KPiA+IENh
ZGVuY2UgTkFORCBjb250cm9sbGVyIElQIGRvIG5vdCBoYXZlIGRlZGljYXRlZCBoYW5kc2hha2Ug
aW50ZXJmYWNlDQo+ID4gdG8gY29ubmVjdCB3aXRoIERNQSBjb250cm9sbGVyLg0KPiA+IE15IHVu
ZGVyc3RhbmRpbmcgaXMgZG1hcyAoYW5kIGRtYS1uYW1lcykgYXJlIG9ubHkgdXNlZCBmb3IgdGhl
DQo+ID4gZGVkaWNhdGVkIGhhbmRzaGFrZSBpbnRlcmZhY2UgYmV0d2VlbiBwZXJpcGhlcmFsIGFu
ZCB0aGUgRE1BIGNvbnRyb2xsZXIuDQo+IA0KPiBJIGRvbid0IHNlZSB3ZWxsIGhvdyB5b3UgY2Fu
IGRlZmVyIGlmIHRoZXJlIGlzIG5vIHJlc291cmNlIHRvIGdyYWIuIEFuZCBpZiB0aGVyZSBpcw0K
PiBhIHJlc291cmNlIHRvIGdyYWIsIHdoeSBpcyBpdCBub3QgZGVzY3JpYmVkIGFueXdoZXJlPw0K
PiANCg0KU2luY2UgTkFORCBjb250cm9sbGVyIGRvIG5vdCBoYXZlIGhhbmRzaGFrZSBpbnRlcmZh
Y2Ugd2l0aCBETUEgY29udHJvbGxlci4NCkRyaXZlciBpcyB1c2luZyBleHRlcm5hbCBETUEgZm9y
IG1lbW9yeS10by1tZW1vcnkgY29weS4gDQoNCllvdXIgcG9pbnQgaXMgc2luY2UgdGhlIGRyaXZl
ciBpcyB1c2luZyBleHRlcm5hbCBETUEgYW5kIGl0IHNob3VsZCBiZSBkZXNjcmliZWQgaW4gYmlu
ZGluZ3M/IA0KDQpUaGFua3MsDQpOaXJhdg0KDQoNCg0KDQoNCg==

