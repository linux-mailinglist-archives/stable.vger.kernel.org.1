Return-Path: <stable+bounces-112134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBFCA26F71
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BC83A78C9
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655420AF7C;
	Tue,  4 Feb 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFQgvHhG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233020125D;
	Tue,  4 Feb 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665819; cv=fail; b=tndnm2u/Azm7UTn6ni32to/brctt4OZxi1mFjxxoCfcvttL6vsBtErYcJgPXjSkaG/3j8lUf0YW22Nij/+aUL0sY9SckuwOMparJBB0AB1armWxt8ciFnbKE4KyS4BTi6kGEMImfbrf4Jn6hD1IUs8Q+U9PN1QVsZ8Kvfi27+JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665819; c=relaxed/simple;
	bh=W9/bbpxxOXaf576h7rqF2N+FXx0J10Q0miyLwzK0VCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJsBxQ2DsjbxvOwWvOqHBG8J6YfSqbUaj/1nIGb6lrx2MzkqiTi9B9dN6C4ACB1kto6MrYSM75YvWUT7eEjO07UnAYsOr9TvpnRnlUqGEkJsQcMiL4mT3JfauWSHf52mhze0MXuHhOPCXXSKpNn2g1kl6SA+bJX1ZTaRUlRFxL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFQgvHhG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738665818; x=1770201818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9/bbpxxOXaf576h7rqF2N+FXx0J10Q0miyLwzK0VCM=;
  b=fFQgvHhGkKrlkvPxnnUpk08GBnS01H5yAn7n9DrPHvZgNjBoXPo7jX0Z
   9WrGGdn0eyXKloGRqaDs4/wg+NI+6/wPHlNZ0Rasu9opn5IouMGbUB7FT
   sCeqovzqHSV5TcopBcOURH9wiZpIYlmPW6BUqqqZfbZue+AxONK4j45a+
   HcF1DS8h8hLTgQDQjKqw70mfa+UufitnIOVwUw5gHRPpPbqxLyoS6XneY
   M6lidb1Dp3wMWuRmo7uSUuIIJNJlcBf/k+RwNrstcVK342siz/IbiNd/+
   YUGvJ8C96LDsxjqPJoBUtI7I6rI3V8n3gLmBspsg6ZAqsETXmFMrF5NMl
   w==;
X-CSE-ConnectionGUID: EH6wwfZUReaLgrugf9YR8Q==
X-CSE-MsgGUID: WPfxO+CKSr2AuGOAlen3JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="50181213"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="50181213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 02:43:38 -0800
X-CSE-ConnectionGUID: TlNT/kNVQLS3dIwRrwnkWQ==
X-CSE-MsgGUID: edwSLEiTRCC1dNXCg628hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="141445225"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 02:43:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 02:43:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 02:43:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 02:43:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Oty9Fichv3OIsyqhpyC6eqU9ouabwTaSm19+LcyFBMVq0rUxGFasfIZIcfFUNl+/zB5/gXk6RI4rwndBZOmjiuq3SiTgH1x7VL53ViTJPFafnCiMUQPog6/k2LPCtlRSr21QxJZxIgeFmSOTYgra3RMkiEeIzM3e6ulkU+XjMswSkjP/E/cW6mBbAKKJh+MYnPaotjd0+pxeZi6oIRadmZGpT64zVPtJ+k5lqRzP/EKZp3DLQBBGLk2Bx/9YhdbmAbIoCYrjj6mgqyNT8L2yNFh+9J15geibr1LYGss2IOBH0mvjrIQQXLKpq2WGpuJ2+F6obeJ8fGb82hDFlBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9/bbpxxOXaf576h7rqF2N+FXx0J10Q0miyLwzK0VCM=;
 b=IjJMxLSFnUQNabEdrglFpk9qgC7BLxVtIkYyGjhdQI+Nd9RWgOXDMwFDBvSERid5uw8zBjreqCfvQTllal9M+tMrYXfdmPWzN//VJ/5QQC/w75+5u4AqfiZmydV2aNwiMI7J8FmFdOD80c2zolMRAFQhjeOc9XtqfnZO47Q3UcIdem7PazKeVpW43nuaAr09MH1nrHTENDIgR6WDj70XoCP+Hq7QN2KIBdErgDVNA2teElbq0ea+FCQV6ewp+sbymkWjhQBvDk+Yk6/NtmIYOlLUutbylcdM8T8AgYVlmvI0WaSB+mKbCFwpPF9jecZH/56V+Lq6ZBY43bf2qT6K8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 10:43:20 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 10:43:20 +0000
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
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQCAA0UcDoAA++LggADu3AKAB1OZ0IAAI5krgAAWHVA=
Date: Tue, 4 Feb 2025 10:43:20 +0000
Message-ID: <BL3PR11MB6532369D14375CC94AA2714BA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	<874j1i0wfq.fsf@bootlin.com>
	<BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87msf8z5uu.fsf@bootlin.com>
	<BL3PR11MB6532451B44E7C5D82F5EC4AFA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
 <87o6zi83se.fsf@bootlin.com>
In-Reply-To: <87o6zi83se.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|SJ2PR11MB8469:EE_
x-ms-office365-filtering-correlation-id: 0aa930e3-c54d-425c-3644-08dd4508bddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzRjN0dPVW1LQjh2YnVNQUhqdkNtR3grS1NlWjFYYnF0a25YUU1IaW84ZTR0?=
 =?utf-8?B?NHdiUy9NalAwbWUxcW9QSjNQYlJMNzIwM2t6UEZsS2hXMnM1OFgrVnpVS1c3?=
 =?utf-8?B?WktJYWVMTDhndUNuZjk5d0tNRG9QektiODRuTTIxVUJEUDFOaWxxUlNyNkgy?=
 =?utf-8?B?MCtPVDdMcnp6VWY3NGdyZTV0dzFzMXJ3ZEhIcTg1d2RkVHVsamUvSGsvTW96?=
 =?utf-8?B?T1RraHdIVFBtM0xuSS9GcFYzSFBsdFJXMEowTG5EYWxjWTg0VVlheXNzRGJU?=
 =?utf-8?B?Wk5kd3RySDh3MStnZGdIUXBQTXFucW9KaHFKWGtsN2NoZFd2ejhGUHlweGVh?=
 =?utf-8?B?bmoxMkQzdEJGRmR0cWRJT2dxcDEyNSt1SXUxbVU0azJ6WERGY2JSRWJYak9o?=
 =?utf-8?B?VEZEUlBMRzZhN0JuZ0ExaENrSlFpUjNYTlVlallydGlIZUFZRFZSUFNMUll4?=
 =?utf-8?B?U3A5c3NCaFN1RHIvbzIrN05zVkJ3VTZESUVoT2ZvRE9JbXFtdHFKbTNseXQz?=
 =?utf-8?B?cS8yc0QxNlRxZENWU0owRlZWRTFlckNqMXVYd2Z4V25lNmJrcTFSQWFzM2l6?=
 =?utf-8?B?QmxWdDczVmRYaGc1VDlYZVIyK3lQZExScUhtWDV3ZmZaYXJPYm8wak9CU2Vw?=
 =?utf-8?B?VHoxeFFDWEVCNjM0SVg5czU0TFRqc0ptMWEzbEZLZHRidS9iRFZMdjJRR2c2?=
 =?utf-8?B?VjhueTZleER5MGF4VGlQd3ZoSWNYZE43ZjlsT3ZnVlZISW0wN2NWOVUyTjBl?=
 =?utf-8?B?RWpGbUtBclFBY1dJQlNveE9kWlFvNVhRS1pQTzFpanZwcDY4M1hwVFlOV3JL?=
 =?utf-8?B?M3I5dmVkOTcxWi9oSGtEazlNNHdYdnFJd3hacE5yYkpXK3o5QmdNcmtZWGU0?=
 =?utf-8?B?eVhtdkxBcldUZWVsczBzang0b2loTW9TQzFwMFpEcnR3OEQxU3BNV0NHL1B6?=
 =?utf-8?B?UkFueTZsb3dZNG5XZzVZRVRadDRiMi8zN3F2eHVIT200TGxTbGxmR21nYVlW?=
 =?utf-8?B?T1dzV3NjWU1MUmg4MTRBakJLNzFXK1BEeitkVVpmSTllMHVhZjBqUE1tUlVt?=
 =?utf-8?B?UGNITG5VTDlTV0FtSnJZR2I0ZDFvVy9uT2dyRnRnOHlBNGMrem92cjIvL0pv?=
 =?utf-8?B?RVNmTzJ2QzlzUEhxSSszNmtXeTltK2dVRktsMlZEd1RWbndhbWFyNWxxRytK?=
 =?utf-8?B?WkR4b2FlZEtsZU9EeWsycU1xTDhFWXg0dTlvLzl2MUExWjNiOEVqcitlQzhy?=
 =?utf-8?B?RGR4ZzB3L3V3dGhPUDlXb2pKTWtMQm4yWm1rdUxubkpoM24yQkgxb0VDTWMy?=
 =?utf-8?B?UVQvS0t1Q25Dd2RkWVYwRFZvb1g3WE1KT2JOYkRycGpYTm8wT1p5S3BjWlZF?=
 =?utf-8?B?aC8veUtBaCtUSTFROHc2RnBPYVo3NEZJWWRiOGdJbFFtWlpxeFMvNjV0L1Ez?=
 =?utf-8?B?S3lqKzBDWmZ5WjJTMFdNaGRBdzhjbW90aURHY0Zyd0xnQkVaekxqWmJzOWs1?=
 =?utf-8?B?Nkg4RlRFZ0R1VmhtT3cyWmUrcWNNc3d5OUZhdGhtMXdhcVFVcXBoRGFPZEJz?=
 =?utf-8?B?cmoxbXMyTDNMT3RxNTRwanlCNzlqVG5OUFkvblo4WkRFUlp2dWFVVFFnalVn?=
 =?utf-8?B?di96elZjU05MUnJCc1E1by95VE04eFB6TUZwUjhUY09MQUl6eFhTRDdSdWRM?=
 =?utf-8?B?NnNCSkgxRVpITXRrMUhHZTRaWXFNL08rVVJLWlR1QWJmaFcyWC9VaExONWxW?=
 =?utf-8?B?WjR3eXZTcmhzUHk4ZmZaT0c2a25QT3VUOTRicVlIWUhjSitNaStFTzk2bS9a?=
 =?utf-8?B?U3d0MTducVU0MlBoSXM5eWprRU54TWJDakVQYXMySmRCak5jUWlwUzVPSHdK?=
 =?utf-8?Q?UqqkmSsuZjB8X?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmtyWHlPcnNZdmJYTkJ1eC8yRFAwMXkwUW8yblFGb0RDZm41akdrR0xwRE9k?=
 =?utf-8?B?ZFZkZUh5cndSRDlMWmhkVFpuSWY2OFVMNkdvZ2RvcVB2K0I3ZWVMYmR2ZjlY?=
 =?utf-8?B?YjhxYi9jWERoWWtxRE9HQUN3YWVyMVBkN0FPaVk1SC9aZEFoY1ZwMVU2OHRC?=
 =?utf-8?B?dGVWRHlIemV4MU9nQ2MxRUpBZ1hRSjdnRFN5Y2h5em03bUhMSVdvZmVzNVBV?=
 =?utf-8?B?b09RejlnWjU3MURsL3dHNHpCTzFtSGdiNVR2M2NmZFR3RE5CNTc3eVN2MSs0?=
 =?utf-8?B?L1BUSGhzSDVmOE10K3lVZzNneVJGa1NsRlpTU2tqQ0JCM2xOcEdmVmZXZ25H?=
 =?utf-8?B?dGs2T3ZFbWt0d0o5T1dGVHhUaWVUMGlVV0J4WHBOcGVrZkRFMHEya3A3M202?=
 =?utf-8?B?YzZ1K2J3aEJaTDVlNTBqVXFyMnVXTjZtaFhCbWkrSkRXM0lQZGxURWVwSVlB?=
 =?utf-8?B?dFNKbXR3bWJId1lnYmlId25aejk2MFBDeFE3VkJ5RlNPR2U1Ti9uaEN3THg3?=
 =?utf-8?B?bGl3UXpITWxOQnZiY2hjVUdCL3FUc04xdzJOSFhBNDMrL2wvSnUvbVYrN2tY?=
 =?utf-8?B?V3dpVDNKTEFLRWg5cmlNeE9RRmZvWFMxWEhxMk5iTWdnSmtyem1Cb2NscnNI?=
 =?utf-8?B?blBwOW5MejdaYUdjOXEveklWbzRmVnRuR2UyWmZ1NHMrSzEwOHF5Sy9Nb0xB?=
 =?utf-8?B?ZG03Q3I5MlRUZ3Uzd09YT0N2WUZIdHVsRTdTaEVpaUNUdTh0OE5XWGdxYjZi?=
 =?utf-8?B?WGh5N1VLa1BiV0pPT1FnSzJsWDdleURSSklERmozd3RTaFlLbFN2UkF4NUY0?=
 =?utf-8?B?bWxzdkNIUENxQWlkYVRJcjRKYk9GT3VMSTM1NU5KMWxxellta2RyRERKcmgr?=
 =?utf-8?B?U1p1OFdiWk1zbEhDY203OFJoaW54b01KSzFUTS9Oam9VZk9zZ3I1UW5GWWJZ?=
 =?utf-8?B?RGZzZmQ5cW1vdW8vbjlmSEJWRXNScFJwbGNZV3V6Rk96R0RyL0NWcVZabUxP?=
 =?utf-8?B?QlR2SkFsSENDS25Wa3hKOVhTZWowMVF5NGg2MUZ0K2F1bjFOOXk5Lzk5U2FU?=
 =?utf-8?B?UEVuWjRPRTcrRHVScHcwQU1nRk82QzVOZ3h5RmNkVjJxYVFSSStJV0IrMEh0?=
 =?utf-8?B?ek55RW9TOVJoUmFJcWY2d28rQjI1azZkZHR1dmlROEEyM3l2ZXVDODBvZlQ1?=
 =?utf-8?B?RFlxUGNGMnM4NzB2VkU4c0lSYnJyTFgybFNsSUZ2KzZtSGtaZTVSZFRFUDFp?=
 =?utf-8?B?K2VtNjk0dzBHZVF5ckZzcnVCbU1HY3g4aUc0MURGdDNSUEd6Q3lSWWFQTkt5?=
 =?utf-8?B?WFUxTjVuYkVaVXBhVXZhL2Z0cWhQSUpTTnRWYUJ2S1JPK3ZyYWloS05IcFRV?=
 =?utf-8?B?NjdEUFZrd3MxTlJKMk5sVEM4L1JpR1ZtQVRoT1FpNUxoWitydG1SaDloeldQ?=
 =?utf-8?B?aXZ6Z1lydzFaSWIyUkxkRWhOak1HcjUzcUlveUxhZWJnbzJkZmpMRStDQUZQ?=
 =?utf-8?B?aFlPdFBIQXRhcmpOVm5mVm9TTTZyMk9CaUZKVS92dlZBS1dQSDVyWDROZ29E?=
 =?utf-8?B?eHNCMHBDazF0UGQxa3llRXd0VCs1Qll6Vi9zZjdLQ00wQ05IWHRpOWJFYnU3?=
 =?utf-8?B?ZkY1bmZmYTBxa1djYzBnc0FmVmRNTW03YmZWM2JCaGVXZGZKUGJEcGNSTndN?=
 =?utf-8?B?MExyM1MwSHc0NmFxL1VPalpGTER5QXhYSGdHQXNIWWxNbVFySGlveFFNS1dY?=
 =?utf-8?B?b21FbTF5M2pSbXZDZk9sOTVVTEJJWkt4RzZzSnYwRmhZNC9aTFR3WWtIbzFR?=
 =?utf-8?B?TE9zQWpwRXQxbUp4NElkdUZ4OHBiU2dLaFVWZnVYTkVpUVpOTEg0cEN4MDR2?=
 =?utf-8?B?emtlT3NNT2J6Z1VZRWRJVXMra3lmeUtkM1oxK1lqRWZpSTR0ZWtHWllhb2hD?=
 =?utf-8?B?MElMc0JzbkQ5Z0NQU3dyeDVUQUx3R2tvdVBGRFA1ZER3MXFSZmNNK1lGUGxp?=
 =?utf-8?B?cXJhNEY1dVR4V00zbzlsOXVFSkZhR2NOOVNwOFhpZWxCUHJLY3hDVDZDdjBD?=
 =?utf-8?B?WmlpOUdmcFh3a0M2Z3k1L3p2a1o1dkVYNGFPN1pqYy8yemxJVTlaWHRrOHlk?=
 =?utf-8?B?cHVZZnIyUVlPU1JLY2Eybmp6RmcxMFo5b3NFemxWRWJMdy9aam5aNDVnTXVw?=
 =?utf-8?B?cWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa930e3-c54d-425c-3644-08dd4508bddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 10:43:20.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3VTJP9mx2VJN+M2jy6F59EQicArq3AuPat1KNUdnoMQyUzJjnCFmtKzoChBipEc3Xwh+EYt3xUsQPvIj+K7fxTvOaWXeFRiocga2OagLOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDQg
RmVicnVhcnksIDIwMjUgNToyMCBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2
a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IGxp
bnV4QHRyZWJsaWcub3JnOyBTaGVuIExpY2h1YW4gPHNoZW5saWNodWFuQHZpdm8uY29tPjsNCj4g
SmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IHUua2xlaW5lLWtvZW5pZ0BiYXls
aWJyZS5jb207IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDEvM10gbXRkOiByYXduYW5kOiBjYWRlbmNlOiBzdXBwb3J0IGRlZmVycmVkIHBy
b2Igd2hlbg0KPiBETUEgaXMgbm90IHJlYWR5DQo+IA0KPiBIZWxsbywNCj4gDQo+ID4gTXkgYXBv
bG9naWVzIGZvciB0aGUgY29uZnVzaW9uLg0KPiA+IFNsYXZlIERNQSB0ZXJtaW5vbG9neSB1c2Vk
IGluIGNhZGVuY2UgbmFuZCBjb250cm9sbGVyIGJpbmRpbmdzIGFuZA0KPiA+IGRyaXZlciBpcyBp
bmRlZWQgY29uZnVzaW5nLg0KPiA+DQo+ID4gVG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24gaXQgaXMs
DQo+ID4gMSAtIEV4dGVybmFsIERNQSAoR2VuZXJpYyBETUEgY29udHJvbGxlcikuDQo+ID4NCj4g
PiBOYW5kIGNvbnRyb2xsZXIgSVAgZG8gbm90IGhhdmUgZW1iZWRkZWQgRE1BIGNvbnRyb2xsZXIg
KDIgLSBwZXJpcGhlcmFsDQo+IERNQSkuDQo+ID4NCj4gPiBGWVIsIGhvdyBleHRlcm5hbCBETUEg
aXMgdXNlZC4NCj4gPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMy4xL3Nv
dXJjZS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9jDQo+ID4gYWRlbmNlLW5hbmQtY29udHJvbGxlci5j
I0wxOTYyDQo+IA0KPiBJbiB0aGlzIGNhc2Ugd2Ugc2hvdWxkIGhhdmUgYSBkbWFzIHByb3BlcnR5
IChhbmQgcGVyaGFwcyBkbWEtbmFtZXMpLCBubz8NCj4gDQpObywgSSBiZWxpZXZlLg0KQ2FkZW5j
ZSBOQU5EIGNvbnRyb2xsZXIgSVAgZG8gbm90IGhhdmUgZGVkaWNhdGVkIGhhbmRzaGFrZSBpbnRl
cmZhY2UgdG8gY29ubmVjdA0Kd2l0aCBETUEgY29udHJvbGxlci4NCk15IHVuZGVyc3RhbmRpbmcg
aXMgZG1hcyAoYW5kIGRtYS1uYW1lcykgYXJlIG9ubHkgdXNlZCBmb3IgdGhlIGRlZGljYXRlZCBo
YW5kc2hha2UNCmludGVyZmFjZSBiZXR3ZWVuIHBlcmlwaGVyYWwgYW5kIHRoZSBETUEgY29udHJv
bGxlci4NCg0KVGhhbmtzLA0KTmlyYXYNCg0K

