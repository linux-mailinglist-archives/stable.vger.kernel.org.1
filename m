Return-Path: <stable+bounces-148053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44EAC777A
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 07:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83464A455D
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 05:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8C25291B;
	Thu, 29 May 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8WuTGZD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC294374D1
	for <stable@vger.kernel.org>; Thu, 29 May 2025 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495645; cv=fail; b=Dn7X8c3cfCbSAfrcYmjkmo5ipNaU+T9XuiuvnZmhP2LUIoGaCZ23WVIiDR+QUDIdbc4DPAkJJBlD2+2qjqNuS+CLcn6SvpBE+Tz9aHQ+oNSkk4fMrB0wMIoUJ3xo68Tl6BL6zldrDxrXOu7pOQuwa7Y1DFJLQbEnWxPcLU5E+XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495645; c=relaxed/simple;
	bh=pQxoZkxZsDeGDhLJanlJt8PRxDkv/zWv8UqUZ2XHG/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMmdBW2nC2rKvU75E7hZW0XvxW6YLZouFNdfKrwIWsBox+NfKHixKCYsDQVrRWPwSDYdOWgaSAdKGysZenhF63gm5OD8jiWDWd/g5YkVxmMQCx6cBCtYyQPePZpw53f3vInlWPETDnsGS5fMPHKshTxUgwTCadJHNlOClLx+ZHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8WuTGZD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748495644; x=1780031644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQxoZkxZsDeGDhLJanlJt8PRxDkv/zWv8UqUZ2XHG/I=;
  b=N8WuTGZDP2Pv9+lSUI+VC8TjVyuDjlx8neycGXKpQx1MEI9pbkfaT7lX
   85jV7sAK7NV6Q9osPHvRJ/nRBAAupccHskGT/7WxeYkNSSTJ0xBSwLD2l
   dYx9UXhr7z8cemJWRYToUXv4us1DzgHZjyBirL9+U3PEdt+OeEHWftqkm
   fJb0nhd0jICj5Tqz/y8QdN4/ODcojCwFAEPh/CeQP8ffrfEsobxnY+ssG
   45qnANnh14HC9t1FwXVGlF9ZNgfBx2z0FGZnKb/pXfcBiaeby5o/fyRM/
   CVWPd2UPx+i8NexVSKHdr1Emgu61lmbCnfUoEjcLuaHHnfXgjJLZCiOjz
   A==;
X-CSE-ConnectionGUID: NM7ywBUgSmanCjB7ICHvIA==
X-CSE-MsgGUID: bWGjqJxwR82z/1HDpRDBfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61596324"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="61596324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:14:02 -0700
X-CSE-ConnectionGUID: pyI0CEDeSSm62PvueAKkfA==
X-CSE-MsgGUID: /gTqDgwrRJqDBzRhmD5Rvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="174329442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:14:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 22:14:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 22:14:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 22:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0sdviS5aHFX4IRERFxAxOsoFYl5wnse6JBss2Jle4qDAC9aWLncI1agHJnEEUyK+ux0QooD8MfJtAZtZr6g3dVA1jbOq9cpUB5CfBRAXIBGZQ0yq4HxVfziqLYW6Gx7A4aCJPo4Acn37LhOlfCh8oVm5DMPR73HlJG2v7vsXVrEKv0bIKULd1FmpCsyMszfVKDjPrAUnHnJnuIqOjOXfXpzgWn0eY53oTMdqh76jjw72WGmqy7v8DCyNM0/vyuUQaJLTvjo9bb8h2maHTmePGwFRQsg51RaYXrMsG8BphGCqSPdnuYxPRUPoUYpjC9LQrCBytUW1F9neSoJLTWjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQxoZkxZsDeGDhLJanlJt8PRxDkv/zWv8UqUZ2XHG/I=;
 b=KGsBklfqbjz+ZSkp8ZwybVVQ64qyE80loLvw7krOG5ZX3r94LmAmBN1D7IJ3c3SVbgHHLV915X2GFyoyEZlBV15XN2hONV0rTrapTgz1rvbSWs3VNgTBVMkN5VnSaSXHl9FZtiiYNeA67tSTpdG+BKq/KjscINmb87PoReVbZreuQkqXxCtXN+zIuItfmBchRhu1gL8AnYKRjlFeDdj3zu4Ms8UnukwMo4GtyfuOqnJJvJXu7dXN4Ak5gKkCWnMTfR+H4frvyM15ShUFX2EBY3i/GdDjF7MvB5DoEHjK3Su9/8dbxlnszG/lNraHw5gUroaNeYgtYJYwFJB/uU+fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 05:13:53 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 05:13:53 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"Brost, Matthew" <matthew.brost@intel.com>, "Tseng, William"
	<william.tseng@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
Thread-Topic: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
Thread-Index: AQHbz8SH5g4FxMr8Wk+Qt063LF2wULPoAsGQgAAXfoCAAPUlUA==
Date: Thu, 29 May 2025 05:13:53 +0000
Message-ID: <SJ1PR11MB620416894FAAF7A4C96BD44C8166A@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20250528113328.289392-2-matthew.auld@intel.com>
 <SJ1PR11MB6204E84396E9C554AE7E80328167A@SJ1PR11MB6204.namprd11.prod.outlook.com>
 <aabaf5db-92aa-4ec9-b0a8-6eb9694fa7c7@intel.com>
In-Reply-To: <aabaf5db-92aa-4ec9-b0a8-6eb9694fa7c7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|IA3PR11MB9325:EE_
x-ms-office365-filtering-correlation-id: e7431baf-57a0-4412-a228-08dd9e6f9ace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a0VhSTE2M1lKOTM3dFRGUjZlazVqM2svRUxEeUp5YVVJZVVjTUwxTTdVRXZI?=
 =?utf-8?B?Q1ZYZ0V2aHA4aTZ1Rm5Pa1BrRVlNTzk0SGFXa0hQNDJJYjc1K0p1Y1JKNlFD?=
 =?utf-8?B?MnFldDNxUC8vNHhJbG5JUmlvK2M1VU5rSis5MzJHQjU0azNjYzMreEtxangv?=
 =?utf-8?B?OTEycnhScENGemRoMXpWUWVKTHFQbGd6Q24xYmJFOVhiTHJqd1dPOUxCV2lv?=
 =?utf-8?B?MDNqK1drZXVZM1FsVHQ1RGxwRFQ4ckZhUjBKUDNsUWw2dnlueWdRWjNRUkZa?=
 =?utf-8?B?RzlNN09jc28wQnRmZVlIL010OTFhR2FtRWM3bHc0cWJVVXl3MWlWZ1pSZlpL?=
 =?utf-8?B?YVZxN3dMbXpGOTdjZUpDWlFmRGNveXEycUlVMkFkTkRSTzhseHgybUU4ZVNK?=
 =?utf-8?B?eENnelRHWmo1WTRrMnVWbnorNjhDeUdMWWdGb2lscVlOS0gzSWJZL0t5VG5i?=
 =?utf-8?B?SzhoSDJkaXZtS0pyQ1dYL2h4c1Vzb09tOUdWQTN1Y3N3eVlRZ3RuWHBMTEhp?=
 =?utf-8?B?RUxFRGVZbHBPQTkybFhubFFER3FiS1FYWGFSTnVIZWQ1T0hOSG84dlA4RWJw?=
 =?utf-8?B?czNPa0xGZ3BLeHhPVVhGUk9HaFFzdFN2dFpZcDdrMHFqVGozb2NGNjZlaXcw?=
 =?utf-8?B?YW81dWlvb3lNUklQc3JWKzB1a0xJcFp5RHc1anAvdHZjNW9URkJCN3BReWlp?=
 =?utf-8?B?VlBSWVM5OVlEYWtkL2pyOExLekpsaGY0RmwwLzQxY0o4T0c3QTd0ODhOSWs2?=
 =?utf-8?B?NG5sWW5XeUl1OURGR2RzcWdqZDNta0drRVRHdVBqNHJOWnY1NU5NbHIzK2tL?=
 =?utf-8?B?WEpuTTRySkxZUzZYWk1MQlBpSjl4d0ZkNGtJNFVQdWpOMU5tY3Y4NWQ4Slh5?=
 =?utf-8?B?cC92OGpqcGRWQjhiMzFTejI4WXhXa3NwTDV1TVBxZmVPN2Jvd2U1cjRoeUZ0?=
 =?utf-8?B?TWd0QUtaRHJUTWZXUGtrT2FCdWNXT3RMWElSRW8zTHdIVElQRVE5MlVQcDl5?=
 =?utf-8?B?Ylh3QUs3K2NPM0lrbFl1ajFTUU94TE9Dc2hYNlk0VDJOM1RjdHptc0Vpb1Np?=
 =?utf-8?B?YnJaNWpzVTlYa25xa0FEcUZPMVIraTlTWXpwYXJ6a20ySVlRbG5GZWpkWTJl?=
 =?utf-8?B?aWVIUEt6YlJBcWlaaVhxYlpGeXNOWHIrMlo1TUk2TEhmM3Fya05PUEVPalBy?=
 =?utf-8?B?eEQ1dFpTOEZJeG1hd0JoS3FwUDRmTkN3VlFETllNNjR2OXM2Nkx2aE9Gc3R6?=
 =?utf-8?B?cVhwUmhDY3JQVmxxdVBUbUxDbE16TGY0VG1DVks5UU5uZjkrMVVRSFBOQWZl?=
 =?utf-8?B?bzNqY3JTR3kwWnZxZ214dHlSL1BjMGVmM0JUMTFFRElHMjVKaTBOVGhlWC9X?=
 =?utf-8?B?aU9SMWlHV09qUlMxempsaXZ1RDA3NUpCdGF2REw0N3JzSGNwRDdNbldwRUVJ?=
 =?utf-8?B?bmtwT2ZKV1ZmMGRrNnpkT2dWYVlpbDVqSTZkOXlUUDdkY08wcnhqUWJta2ly?=
 =?utf-8?B?UTgxK0Vhc2pjVGsxWXRHSFYrdGY0cUNaR1JvYjloc2pwRUN0UmFPTk1aK0to?=
 =?utf-8?B?NXF5L1lGS2orR0U1MUg1V2k1a1VVSG8wZk9ROTE2bmZ2WWhKSS9QMnk4QmJs?=
 =?utf-8?B?eGdmb09VWXBqVnZXTjFSQmk0Wm8wY05pNjB1Y3duN3RYODhIcFE3VFVaazNJ?=
 =?utf-8?B?dnEzSDU2ejUvZkoxWFZVSWt6MGlJWW9ibDljaXRRR2IyUWtSNFZ1bHNoMERi?=
 =?utf-8?B?KzBGRkJSWk5yR0cvVmkvZ1l1WTQ2NkNrWUd2MkU4bWtkRFlwMDErYUl3Zkw1?=
 =?utf-8?B?ZDg3elVESjlFSkxUYlBYc2hScENjUWRCQ3pQeUZKQ0dpa0xTRUt6eHZhMVFS?=
 =?utf-8?B?a2FKcGRwQUpTN0JsR1JVUldudmdoQlFOZngzc1daMHUyemtRZWdDTFdGcldr?=
 =?utf-8?Q?VZnt2v93Lsg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGdlWjZIcFJLOEJMSk1HTzBITm5XY1pBOE0yQUdHV2MxamlyVGtSUEhxTzl0?=
 =?utf-8?B?Y1krZXd3OWhvUG9YRWRVYjZ1dVUzN2kyQTNRK0V1Ukx6OUE3dUlXblJvc2V4?=
 =?utf-8?B?SkltL0t1ck1lZTdXeEtRLzZNSVdPV2pXNG16ODRvTjE5ZmtTWjRLeWdtV2F0?=
 =?utf-8?B?T1JQcTVCejJmSmE0UHczWitPWlYzYklzKzBUcGZuOXBSc3U5RTh2QnFsVzFI?=
 =?utf-8?B?VHVzcVpncEZjYkxudGlRTk1TSEZGdHBtNHZEQk9jRjlUUU0zWkpqU1A5azhu?=
 =?utf-8?B?RlNRTFp3WHR6NWt6U2VUZzZ6UWZSNzhtOW9yN2NiSGhTOS9zTlJpUG5lVkNn?=
 =?utf-8?B?clo5NkhqY3hyQU9mN3JoN0NQYkJQS2kvSVN1dkVrQm9zc0U2SVlGKy9VczhX?=
 =?utf-8?B?bGJwU2hGM1czdVQzUktkOVVvVWV5S3NvTWdrcUEzUThkeWxLNllPV1pvUTVv?=
 =?utf-8?B?UUtQbFQwR2NnbFQ2UURXQWw4cE5DM1BUTGE4RmEvVU81d3JHYmY0THhSOWRI?=
 =?utf-8?B?RWorN3MwQUtNVTZlUE0xQzlBaFdFS2U1UEJRQzFvM2Y2aVYyYzR5THJBa1Ay?=
 =?utf-8?B?bVZrR2R5dlNZK05xVEJpVW9IcnVJS2RrbWR3bnFHT2dCMHlJWVBJQnBQQkNk?=
 =?utf-8?B?OTRWV1VycEg4UGRXb1lQekdmWnAyamtoRzVpYXp0dHVIYVEyM3dQTU5PeENa?=
 =?utf-8?B?UTMzVlZNZEtESnM0U0lIWnU0eGhpWWVvS3NheUlNWElqcnhCeTV1NnZTaEZO?=
 =?utf-8?B?T3N5QzZrLzRET1JUSVVtNWxhQXYzT1lpSTNFbVJnRG1qUDRpTWJmb2dTci9H?=
 =?utf-8?B?aWd4a3ZTTlRGeG1oK3JRSkt3QjBQOGhweGlOSnNHZHY3RjJYVjJIZERuS1JK?=
 =?utf-8?B?N1I0MXVlZk9rY3NpMGRPVkYyZUZFTTVmQzM5dTF0bW84czJoNVVJVjM3SDdI?=
 =?utf-8?B?bnBVM1huOG9LUit4Z0xIRndVcG5udmdIT2paVjFqTTFqMzMxSFA2THYySlFZ?=
 =?utf-8?B?eVBueFpnVUdsdytLOWtqcVJWcG9qMElSeGduZldBclhJaTVBOFloSHdFM3c2?=
 =?utf-8?B?SzRiSllYYU16Y0h1TW93RWhiT2hEMU14N29zVXBybXptblBzUFhqUlRFa2hF?=
 =?utf-8?B?VFNGSmpvZ3B6VGVSZGJwOGgydzV2eFdpUW5ZNlozTi9hOHBmZDA4Q1ozei9Y?=
 =?utf-8?B?Qnh6bEl0cFBPYWoyZ0VLWWlLajRGZkF6aHpwYkdTSnJJb3Q1U21LMUliZWpa?=
 =?utf-8?B?c2EvUkhYMlhiRElGV2MzRW1sbDBiN2g5LzFDRTd6N0tpZXhNVTEvZUc5UGF0?=
 =?utf-8?B?aW9Ba2t5Vlg3WnEzVHJwUDhVeW92WTdqZlQ4QjBqOUIyTXVVdndrM2w2NDRk?=
 =?utf-8?B?aHNYejFFOTZBNFVrNlFHRFYzMVJ1MGdVclZuNFVLSTFYbmluSkYrRk1CVlJo?=
 =?utf-8?B?WDZZQlhGb3pRTzZxeGwwRXR5Ym9lRDgxcUVqaHQwazFjdG1BU3JqeWpOeHkx?=
 =?utf-8?B?WWZxUTkrUmR6OFNBMmlxY1NiSUZaUGgrbHRCSkxRQ1MvSXJnU3E5QzZKUmFw?=
 =?utf-8?B?cGFxYk9acTQvSWxyWEI1Qml0SGpod3dJeU9nd1RVNTRNUjg4Tkg1UWlEY2Jw?=
 =?utf-8?B?d2JBQU9KVnBOWWtaTTBhMkk3a3RyMy9EQzYrYlRWMUh3a2ZaOFpMckRwMlJR?=
 =?utf-8?B?YytlcndHa1Qyc09CQnhBMWtoKzJGNEhKUmJVZit1Z01qdDFpUFNBVUUwWW5V?=
 =?utf-8?B?TmgrdThMand2VWhsTnRFdjliWmplNkw0MU1YeEd0Z3l5OUhUcjg4cXEvVE1D?=
 =?utf-8?B?S0g5MFBBNFpwU0tkZllRVHZEMU5FK0VMM1NKWE5VMElxNExsRXZ5VXlheHBj?=
 =?utf-8?B?YWZ4MHhtMzdEQXlPV2VnSzgrZzFlNDZDaTFWOXhjb3FQNW1VM1NyZmpFTU5R?=
 =?utf-8?B?enByUUlqb0QvcHlQNzZpTWZSdVdtY2FycEd0OGtyclVrVC90OU4xZ2gzdEVP?=
 =?utf-8?B?QzRKV0RYcVF5MGNIc3dZQjJjRWhNZndBais1Z1gyczdjTnRLSU9taGFMeTU3?=
 =?utf-8?B?Z0w2V01YZ2lDOXZFYS9UTkozbGd1U2pEQUova1AxRnpjVzFBengzYTQzcVVo?=
 =?utf-8?Q?PX5L6XA6+Y/Hv3qVFGVx5/M5D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7431baf-57a0-4412-a228-08dd9e6f9ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 05:13:53.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUfhWoGWLpdcQfcM0Vd0XrAaMj60OvtvyJk4v+AlMeOWkizJdw2U93Rqu2iHWegShCmbbCNVpbxe7jARSy8Abu7lwdIuEVzOmZj3G4leAgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9325
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogMjggTWF5IDIwMjUgMTk6NTkNCj4gVG86
IFVwYWRoeWF5LCBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgaW50ZWwtDQo+IHhl
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5o
ZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgQnJvc3QsIE1hdHRoZXcNCj4gPG1hdHRoZXcuYnJv
c3RAaW50ZWwuY29tPjsgVHNlbmcsIFdpbGxpYW0gPHdpbGxpYW0udHNlbmdAaW50ZWwuY29tPjsN
Cj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBkcm0v
eGUvc2NoZWQ6IHN0b3AgcmUtc3VibWl0dGluZyBzaWduYWxsZWQgam9icw0KPiANCj4gT24gMjgv
MDUvMjAyNSAxNDowNiwgVXBhZGh5YXksIFRlamFzIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSW50ZWwteGUgPGludGVsLXhlLWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPj4gTWF0dGhldyBB
dWxkDQo+ID4+IFNlbnQ6IDI4IE1heSAyMDI1IDE3OjAzDQo+ID4+IFRvOiBpbnRlbC14ZUBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVs
bHN0cm9tQGxpbnV4LmludGVsLmNvbT47IEJyb3N0LA0KPiA+PiBNYXR0aGV3IDxtYXR0aGV3LmJy
b3N0QGludGVsLmNvbT47IFRzZW5nLCBXaWxsaWFtDQo+ID4+IDx3aWxsaWFtLnRzZW5nQGludGVs
LmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogW1BBVENIIHYzXSBk
cm0veGUvc2NoZWQ6IHN0b3AgcmUtc3VibWl0dGluZyBzaWduYWxsZWQgam9icw0KPiA+Pg0KPiA+
PiBDdXN0b21lciBpcyByZXBvcnRpbmcgYSByZWFsbHkgc3VidGxlIGlzc3VlIHdoZXJlIHdlIGdl
dCByYW5kb20gRE1BUg0KPiA+PiBmYXVsdHMsIGhhbmdzIGFuZCBvdGhlciBuYXN0aWVzIGZvciBr
ZXJuZWwgbWlncmF0aW9uIGpvYnMgd2hlbg0KPiA+PiBzdHJlc3Npbmcgc3R1ZmYgbGlrZSBzMmlk
bGUvczMvczQuIFRoZSBleHBsb3Npb25zIHNlZW1zIHRvIGhhcHBlbg0KPiA+PiBzb21ld2hlcmUg
YWZ0ZXIgcmVzdW1pbmcgdGhlIHN5c3RlbSB3aXRoIHNwbGF0cyBsb29raW5nIHNvbWV0aGluZyBs
aWtlOg0KPiA+Pg0KPiA+PiBQTTogc3VzcGVuZCBleGl0DQo+ID4+IHJma2lsbDogaW5wdXQgaGFu
ZGxlciBkaXNhYmxlZA0KPiA+PiB4ZSAwMDAwOjAwOjAyLjA6IFtkcm1dIEdUMDogRW5naW5lIHJl
c2V0OiBlbmdpbmVfY2xhc3M9YmNzLCBsb2dpY2FsX21hc2s6DQo+ID4+IDB4MiwgZ3VjX2lkPTAg
eGUgMDAwMDowMDowMi4wOiBbZHJtXSBHVDA6IFRpbWVkb3V0IGpvYjogc2Vxbm89MjQ0OTYsDQo+
ID4+IGxyY19zZXFubz0yNDQ5NiwgZ3VjX2lkPTAsIGZsYWdzPTB4MTMgaW4gbm8gcHJvY2VzcyBb
LTFdIHhlIDAwMDA6MDA6MDIuMDoNCj4gPj4gW2RybV0gR1QwOiBLZXJuZWwtc3VibWl0dGVkIGpv
YiB0aW1lZCBvdXQNCj4gPj4NCj4gPj4gVGhlIGxpa2VseSBjYXVzZSBhcHBlYXJzIHRvIGJlIGEg
cmFjZSBiZXR3ZWVuIHN1c3BlbmQgY2FuY2VsbGluZyB0aGUNCj4gPj4gd29ya2VyIHRoYXQgcHJv
Y2Vzc2VzIHRoZSBmcmVlX2pvYigpJ3MsIHN1Y2ggdGhhdCB3ZSBzdGlsbCBoYXZlDQo+ID4+IHBl
bmRpbmcgam9icyB0byBiZSBmcmVlZCBhZnRlciB0aGUgY2FuY2VsLiBGb2xsb3dpbmcgZnJvbSB0
aGlzLCBvbg0KPiA+PiByZXN1bWUgdGhlIHBlbmRpbmdfbGlzdCB3aWxsIG5vdyBjb250YWluIGF0
IGxlYXN0IG9uZSBhbHJlYWR5DQo+ID4+IGNvbXBsZXRlIGpvYiwgYnV0IGl0IGxvb2tzIGxpa2Ug
d2UgY2FsbCBkcm1fc2NoZWRfcmVzdWJtaXRfam9icygpLA0KPiA+PiB3aGljaCB3aWxsIHRoZW4g
Y2FsbA0KPiA+PiBydW5fam9iKCkgb24gZXZlcnl0aGluZyBzdGlsbCBvbiB0aGUgcGVuZGluZ19s
aXN0LiBCdXQgaWYgdGhlIGpvYiB3YXMNCj4gPj4gYWxyZWFkeSBjb21wbGV0ZSwgdGhlbiBhbGwg
dGhlIHJlc291cmNlcyB0aWVkIHRvIHRoZSBqb2IsIGxpa2UgdGhlIGJiDQo+ID4+IGl0c2VsZiwg
YW55IG1lbW9yeSB0aGF0IGlzIGJlaW5nIGFjY2Vzc2VkLCB0aGUgaW9tbXUgbWFwcGluZ3MgZXRj
Lg0KPiA+PiBtaWdodCBiZSBsb25nIGdvbmUgc2luY2UgdGhvc2UgYXJlIHVzdWFsbHkgdGllZCB0
byB0aGUgZmVuY2Ugc2lnbmFsbGluZy4NCj4gPj4NCj4gPj4gVGhpcyBzY2VuYXJpbyBjYW4gYmUg
c2VlbiBpbiBmdHJhY2Ugd2hlbiBydW5uaW5nIGEgc2xpZ2h0bHkgbW9kaWZpZWQNCj4gPj4geGVf
cG0gKGtlcm5lbCB3YXMgb25seSBtb2RpZmllZCB0byBpbmplY3QgYXJ0aWZpY2lhbCBsYXRlbmN5
IGludG8NCj4gPj4gZnJlZV9qb2IgdG8gbWFrZSB0aGUgcmFjZSBlYXNpZXIgdG8gaGl0KToNCj4g
Pj4NCj4gPj4geGVfc2NoZWRfam9iX3J1bjogZGV2PTAwMDA6MDA6MDIuMCwgZmVuY2U9MHhmZmZm
ODg4Mjc2Y2M4NTQwLA0KPiA+PiBzZXFubz0wLCBscmNfc2Vxbm89MCwgZ3Q9MCwgZ3VjX2lkPTAs
IGJhdGNoX2FkZHI9MHgwMDAwMDAxNDY5MTAgLi4uDQo+ID4+IHhlX2V4ZWNfcXVldWVfc3RvcDog
ICBkZXY9MDAwMDowMDowMi4wLCAzOjB4MiwgZ3Q9MCwgd2lkdGg9MSwgZ3VjX2lkPTAsDQo+ID4+
IGd1Y19zdGF0ZT0weDAsIGZsYWdzPTB4MTMNCj4gPj4geGVfZXhlY19xdWV1ZV9zdG9wOiAgIGRl
dj0wMDAwOjAwOjAyLjAsIDM6MHgyLCBndD0wLCB3aWR0aD0xLCBndWNfaWQ9MSwNCj4gPj4gZ3Vj
X3N0YXRlPTB4MCwgZmxhZ3M9MHg0DQo+ID4+IHhlX2V4ZWNfcXVldWVfc3RvcDogICBkZXY9MDAw
MDowMDowMi4wLCA0OjB4MSwgZ3Q9MSwgd2lkdGg9MSwgZ3VjX2lkPTAsDQo+ID4+IGd1Y19zdGF0
ZT0weDAsIGZsYWdzPTB4Mw0KPiA+PiB4ZV9leGVjX3F1ZXVlX3N0b3A6ICAgZGV2PTAwMDA6MDA6
MDIuMCwgMToweDEsIGd0PTEsIHdpZHRoPTEsIGd1Y19pZD0xLA0KPiA+PiBndWNfc3RhdGU9MHgw
LCBmbGFncz0weDMNCj4gPj4geGVfZXhlY19xdWV1ZV9zdG9wOiAgIGRldj0wMDAwOjAwOjAyLjAs
IDQ6MHgxLCBndD0xLCB3aWR0aD0xLCBndWNfaWQ9MiwNCj4gPj4gZ3VjX3N0YXRlPTB4MCwgZmxh
Z3M9MHgzDQo+ID4+IHhlX2V4ZWNfcXVldWVfcmVzdWJtaXQ6IGRldj0wMDAwOjAwOjAyLjAsIDM6
MHgyLCBndD0wLCB3aWR0aD0xLA0KPiA+PiBndWNfaWQ9MCwgZ3VjX3N0YXRlPTB4MCwgZmxhZ3M9
MHgxMw0KPiA+PiB4ZV9zY2hlZF9qb2JfcnVuOiBkZXY9MDAwMDowMDowMi4wLCBmZW5jZT0weGZm
ZmY4ODgyNzZjYzg1NDAsDQo+ID4+IHNlcW5vPTAsIGxyY19zZXFubz0wLCBndD0wLCBndWNfaWQ9
MCwgYmF0Y2hfYWRkcj0weDAwMDAwMDE0NjkxMCAuLi4NCj4gPj4gLi4uLi4NCj4gPj4geGVfZXhl
Y19xdWV1ZV9tZW1vcnlfY2F0X2Vycm9yOiBkZXY9MDAwMDowMDowMi4wLCAzOjB4MiwgZ3Q9MCwN
Cj4gPj4gd2lkdGg9MSwgZ3VjX2lkPTAsIGd1Y19zdGF0ZT0weDMsIGZsYWdzPTB4MTMNCj4gPj4N
Cj4gPj4gU28gdGhlIGpvYl9ydW4oKSBpcyBjbGVhcmx5IHRyaWdnZXJlZCB0d2ljZSBmb3IgdGhl
IHNhbWUgam9iLCBldmVuDQo+ID4+IHRob3VnaCB0aGUgZmlyc3QgbXVzdCBoYXZlIGFscmVhZHkg
c2lnbmFsbGVkIHRvIGNvbXBsZXRpb24gZHVyaW5nDQo+ID4+IHN1c3BlbmQuIFdlIGNhbiBhbHNv
IHNlZSBhIENBVCBlcnJvciBhZnRlciB0aGUgcmUtc3VibWl0Lg0KPiA+Pg0KPiA+PiBUbyBwcmV2
ZW50IHRoaXMgdHJ5IHRvIGNhbGwgeGVfc2NoZWRfc3RvcCgpIHRvIGZvcmNlZnVsbHkgcmVtb3Zl
DQo+ID4+IGFueXRoaW5nIG9uIHRoZSBwZW5kaW5nX2xpc3QgdGhhdCBoYXMgYWxyZWFkeSBzaWdu
YWxsZWQsIGJlZm9yZSB3ZSByZS0NCj4gc3VibWl0Lg0KPiA+Pg0KPiA+PiB2MjoNCj4gPj4gICAg
LSBNYWtlIHN1cmUgdG8gcmUtYXJtIHRoZSBmZW5jZSBjYWxsYmFja3Mgd2l0aCBzY2hlZF9zdGFy
dCgpLg0KPiA+PiB2MyAoTWF0dCBCKToNCj4gPj4gICAgLSBTdG9wIHVzaW5nIGRybV9zY2hlZF9y
ZXN1Ym1pdF9qb2JzKCksIHdoaWNoIGFwcGVhcnMgdG8gYmUNCj4gZGVwcmVjYXRlZA0KPiA+PiAg
ICAgIGFuZCBqdXN0IG9wZW4tY29kZSBhIHNpbXBsZSBsb29wIHN1Y2ggdGhhdCB3ZSBza2lwIGNh
bGxpbmcgcnVuX2pvYigpDQo+ID4+ICAgICAgYW5kIGFueXRoaW5nIGFscmVhZHkgc2lnbmFsbGVk
Lg0KPiA+Pg0KPiA+PiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hl
L2tlcm5lbC8tL2lzc3Vlcy80ODU2DQo+ID4+IEZpeGVzOiBkZDA4ZWJmNmMzNTIgKCJkcm0veGU6
IEludHJvZHVjZSBhIG5ldyBEUk0gZHJpdmVyIGZvciBJbnRlbA0KPiA+PiBHUFVzIikNCj4gPj4g
U2lnbmVkLW9mZi1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiA+
PiBDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29t
Pg0KPiA+PiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+ID4+
IENjOiBXaWxsaWFtIFRzZW5nIDx3aWxsaWFtLnRzZW5nQGludGVsLmNvbT4NCj4gPj4gQ2M6IDxz
dGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjgrDQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMv
Z3B1L2RybS94ZS94ZV9ncHVfc2NoZWR1bGVyLmggfCAxMCArKysrKysrKystDQo+ID4+ICAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2dwdV9zY2hlZHVsZXIuaA0KPiA+PiBi
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ncHVfc2NoZWR1bGVyLmgNCj4gPj4gaW5kZXggYzI1MGVh
NzczNDkxLi4zMDgwNjFmMGNmMzcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94
ZS94ZV9ncHVfc2NoZWR1bGVyLmgNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2dw
dV9zY2hlZHVsZXIuaA0KPiA+PiBAQCAtNTEsNyArNTEsMTUgQEAgc3RhdGljIGlubGluZSB2b2lk
IHhlX3NjaGVkX3Rkcl9xdWV1ZV9pbW0oc3RydWN0DQo+ID4+IHhlX2dwdV9zY2hlZHVsZXIgKnNj
aGVkKQ0KPiA+Pg0KPiA+PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZV9zY2hlZF9yZXN1Ym1pdF9q
b2JzKHN0cnVjdCB4ZV9ncHVfc2NoZWR1bGVyDQo+ICpzY2hlZCkgIHsNCj4gPj4gLQlkcm1fc2No
ZWRfcmVzdWJtaXRfam9icygmc2NoZWQtPmJhc2UpOw0KPiA+PiArCXN0cnVjdCBkcm1fc2NoZWRf
am9iICpzX2pvYjsNCj4gPj4gKw0KPiA+PiArCWxpc3RfZm9yX2VhY2hfZW50cnkoc19qb2IsICZz
Y2hlZC0+YmFzZS5wZW5kaW5nX2xpc3QsIGxpc3QpIHsNCj4gPj4gKwkJc3RydWN0IGRybV9zY2hl
ZF9mZW5jZSAqc19mZW5jZSA9IHNfam9iLT5zX2ZlbmNlOw0KPiA+PiArCQlzdHJ1Y3QgZG1hX2Zl
bmNlICpod19mZW5jZSA9IHNfZmVuY2UtPnBhcmVudDsNCj4gPj4gKw0KPiA+PiArCQlpZiAoaHdf
ZmVuY2UgJiYgIWRtYV9mZW5jZV9pc19zaWduYWxlZChod19mZW5jZSkpDQo+ID4+ICsJCQlzY2hl
ZC0+YmFzZS5vcHMtPnJ1bl9qb2Ioc19qb2IpOw0KPiA+PiArCX0NCj4gPg0KPiA+IFdoaWxlIHRo
aXMgY2hhbmdlIGxvb2tzIGNvcnJlY3QsIHdoYXQgYWJvdXQgdGhvc2UgaGFuZ2luZyBjb250ZXh0
cyB3aGljaCBpcw0KPiBpbmRpY2F0ZWQgdG8gd2FpdGVycyBieSBkbWFfZmVuY2Vfc2V0X2Vycm9y
KCZzX2ZlbmNlLT5maW5pc2hlZCwgLQ0KPiBFQ0FOQ0VMRUQpOyENCj4gDQo+IEkgdGhpbmsgYSBo
YW5naW5nIGNvbnRleHQgd2lsbCB1c3VhbGx5IGJlIGJhbm5lZCwgc28gd2Ugc2hvdWxkbid0IHJl
YWNoIHRoaXMNCj4gcG9pbnQgQUZBSUNULiBDYW4geW91IHNoYXJlIHNvbWUgbW9yZSBpbmZvIG9u
IHdoYXQgeW91ciBjb25jZXJuIGlzIGhlcmU/IEkNCj4gZG9uJ3QgdGhpbmsgd2Ugd291bGQgbm9y
bWFsbHkgd2FudCB0byBjYWxsIHJ1bl9qb2IoKSBhZ2FpbiBvbiBqb2JzIGZyb20gYQ0KPiBoYW5n
aW5nIGNvbnRleHQuIEl0IGxvb2tzIGxpa2Ugb3VyIHJ1bl9qb2IoKSB3aWxsIGJhaWwgaWYgdGhl
IGh3IGZlbmNlIGlzIG1hcmtlZA0KPiB3aXRoIGFuIGVycm9yLg0KDQpPaywgSSBzZWUgd2UgZGV0
ZWN0IHRoZSBoYW5naW5nIGFuZCBzZXR0aW5nIGpvYnMgdGhyb3VnaCB4ZV9zY2hlZF9qb2Jfc2V0
X2Vycm9yKCkgYW5kIHdpbGwgYmUgc2lnbmFsbGVkLiBJIGFtIGZpbmUgaGVyZS4NCg0KUmV2aWV3
ZWQtYnk6IFRlamFzIFVwYWRoeWF5IDx0ZWphcy51cGFkaHlheUBpbnRlbC5jb20+DQoNClRlamFz
IA0KPiANCj4gPg0KPiA+IFRlamFzDQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiAgIHN0YXRpYyBpbmxp
bmUgYm9vbA0KPiA+PiAtLQ0KPiA+PiAyLjQ5LjANCj4gPg0KDQo=

