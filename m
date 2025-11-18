Return-Path: <stable+bounces-195132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F9C6B899
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AAAAD2B1AA
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA12F5A25;
	Tue, 18 Nov 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxRLg0UF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B92F39A0
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496775; cv=fail; b=oBnQFX6cTJEnMWjPp8Mb/4pABg5tLpPtcV2iGKECw0CAnRtU4Pmpl7FpwZL9J1mujlJP4/uEpuKRmVTTtxveHyOmX7T7YDHwP26rD5Pb9FfRxZrdo9VKsahwdx8zSkDMZkyyFOvkRMuUZD+3bX1FfhH9np850KZrItL/pivpt1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496775; c=relaxed/simple;
	bh=/bWTLnUalF1EvcGSmy85sGq9JTW2J8YNYGH9zizsHJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gs6t3YrZ9VMzJhRmER9eK+OlgY5kQd1y+nL13UFxUGoIn34rTWe22YZajKwYr2q41QWQ54M8b9veyPd1xljLJfDtjfJCCUpglaopwmQtNTTIgFrFrr0V/athpiwpHVFhFbQOGSf/kwsUGzlrsZFjTbPuQMVexLzozmCEbu9MVI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxRLg0UF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763496774; x=1795032774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/bWTLnUalF1EvcGSmy85sGq9JTW2J8YNYGH9zizsHJA=;
  b=gxRLg0UFgGcvFPTydz7Ykzg8pMDgdTti1AoJbMSp4lx4aFLQ8QBqyUjK
   Y50MSeVi/XzHWWr+5lVOqM9KpbArOpW9EXjZYpFUMIhISQ+LeRAJcTrp5
   UbRGsKbY0IjBZMCV6tEWy+v5eKI/pIr5fPOQvdfe04JIjmDatF4MHTF9Q
   Gr1xguYqzXolYxieqw7r9LDeoOCGuqdCdXx19DWsy8zd3XaCeRaJ+6AaG
   4zJgNvH5iM4NKxcrVI1mfYbqbR4tEmL0u3bpKp+M6QZqBscq9i83sh6hr
   lDxOpzAV3idO55HSUCAmT5EIABVulqXQFyHjTassG+Mz3mUtqWAdGQqTG
   Q==;
X-CSE-ConnectionGUID: qW2vN9JdRU6L5oG/XDWd3Q==
X-CSE-MsgGUID: i9eziWPbSlidrNL2nLtQnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69383959"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69383959"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:12:53 -0800
X-CSE-ConnectionGUID: +NUz9WdCTkypyj2yay8ccw==
X-CSE-MsgGUID: 6tIy0d6CSQKTroMeRd5IuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190659134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:12:53 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:12:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 12:12:52 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:12:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbn10bzxm/bgHtpTumRKNn3mq7DGNdELHPRw/g/GgFoYW8gZHyzC1pugzFycFvRVXDxuvvyXfDTR/Ve4dG8mJZeizHWf32aHE1ooPByyzHbuipUpArN1j+CWVVZFv+B921cxoeCQPPUpf/wlilrCjsAn64RPDTD9NzdjrTKHrtY6FWaamcPWTP1tGqe6oDOeGFJQHOwn6TxVaIBZjnqFu7EprB2UbibHb6pelGcaClQMIcR2LL6fpi32wfmaZYoZ/hCI5JK+qbjklEsumpoLXK8ZIURKFDNBHxiHvGsiI9b1FUEFIAeLaj8UFg5iO+XdtpcD7hDqzbEW91R8po/xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bWTLnUalF1EvcGSmy85sGq9JTW2J8YNYGH9zizsHJA=;
 b=qZ7n72XPtdjAXnFTsDGG91lbMyqc3BRya5gWKzLdNGdV8TbbacV2kclnMyFwR2QL1tU6F/0i2qmyi++28qme39ykTMCro37XFNO71Q+we8V9K8MPOeoOsfsLFHRLPZYawzlycN7cjDK2sHNF81W/4LcW8EAwkr8n/jSN0dlU6GiLIgqMNXF3P3oyo87NWvlOz5ZkFIg1BtJ8nwbWM5L82LAu49GSiiZwUSQfcl3LeZeMX0A7ittZH9bSnabGTt/9iGuZs8q793KSIZ7v53LpXr3HXOhBton15AA5dwaNTLqhoDfDmQzpLNobjbAM1CDzrTzYzWrS0VvutM/vLT6f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 20:12:50 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 20:12:50 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Ghuge,
 Sagar" <sagar.ghuge@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Ceraolo Spurio, Daniele"
	<daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Thread-Topic: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Thread-Index: AQHcWL7NkYmkeZfCakm2feQqaxPhvLT40buAgAAGBQCAAAViAIAAAMsA
Date: Tue, 18 Nov 2025 20:12:49 +0000
Message-ID: <65939d6dfe363b41b1d9d6251d166d1cc6b49683.camel@intel.com>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
	 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
	 <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
	 <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
	 <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
In-Reply-To: <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: 566968b7-0cbe-4831-2643-08de26ded91e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RFg2RlBVdVMrbkZpZ08vM1FlZ2o2TE5uM1QxTlVDeVRoMGxzS1BqYzVVQk5M?=
 =?utf-8?B?aHZuOWk2aTVKZDhIU2ZmQlB6aGJHM1ZWa2JVMTYxUk1Eb2poZzJZNW4rYkhG?=
 =?utf-8?B?eE1iZ2JnRXJHYnA3YTVIbE9ESHdXNUtZY0NyYm1tL0JBcjBVNWpzemEzeGtL?=
 =?utf-8?B?aktSNWkvU1ZhVEgyUmlBczJsK29iekFGdkNzQ3hXNStEY0x1aFRRQ2J0em1S?=
 =?utf-8?B?Q1BkTVhNQk1tTHNGRGNSOEZVRWwraWdrRW8yb3FTR0tGcXQxK0QxS052dDQ5?=
 =?utf-8?B?ZnpCM0h1OTNTRFgrQjJ1b29PNUloS01hbTNDWHgvcklocCtCd3JFN3ptQ1No?=
 =?utf-8?B?YnB1c0ZjZERmWW1kSXZ5K0I3aGR2M0RXZk5XbHlWNnFuWVpqVzR2R1ZQb0pH?=
 =?utf-8?B?dE1tK0MzZldJeGk1anhUOW5BL3o0VmVMTEJCWGhpSFVtOHk4ZXdpc3VyUUpw?=
 =?utf-8?B?K1pzc1JyWkJHSlJRbnFoZ0g2ekFuSnhJUXpvNW9QcXY1T1lqQkFiVHJ4M1hP?=
 =?utf-8?B?UFlXZCtjNUd5em5NSFp3bDBKOUFoQ0J4UzhRS2RJdW1wV1dHeTRSbXovTVY4?=
 =?utf-8?B?SmNUT293K2pnWnVRNnJSeEQrUkdQVG5HSE1mbEt2UXA2L2FYTFV3ZS9kbHJZ?=
 =?utf-8?B?Zk9UdU9QNDA5Y2RtNTR0RmpCTFJsZFFOeDVsbHBJWlo4ODBiS08xbTRxSmxP?=
 =?utf-8?B?c0FwT3Vkd0I2UFpzM3VnSHRnb3plNnZJTW9OVHZpMi9ZS1dUU2UrUDJabGly?=
 =?utf-8?B?OVZwamg4OE5XRjc2MjRqV01UeUlHVnNUeDFENTNOWHFBWXVjZ2JVQmh6VzdN?=
 =?utf-8?B?MGtjVVBuck1kL0VHeHpyZjdacUszVFFJQisxYmR6RUJ0N1JjeHVILzg3bTcv?=
 =?utf-8?B?ZWN1QXNMRkFvYk5Md1J0dndhNGlmNjI5QXQzb2w4US9NWDJWdml4ME1WdVZP?=
 =?utf-8?B?a1R4MFAzSEhlYStpSEI5UVF3SzRVZFo5bGlyTGJyQi9lajljeTN0N3ZKbSts?=
 =?utf-8?B?aS84REx6WHdKTDdtempxS2lzRWVaYnc3MTU0V1lZb1JWQ3lNTkNCUnBGMTh2?=
 =?utf-8?B?OUQxbVRla0RnVElCQ0VFNjhON1RYSU1NT2pkVDZJbFVOVXVOZWx2MktPZFc4?=
 =?utf-8?B?S3pEKzViZUhJcWlkMTZWekU3TzJHc1dMZHVEL1R6RUxqbFo4RGw2SmpXWGho?=
 =?utf-8?B?c2ZmQkVQNXo3Z1FaQlJ3S0NsOU42STFna3BrUjI5aDlhN0ZVemxkYUppSmZC?=
 =?utf-8?B?YXU1WUxpTkVxTXNrRmxtcXJveUZ6emNTdHFSOXZSUDJNZ241S0xqYmN1TGRm?=
 =?utf-8?B?YXBBV0ZGQzV4R2dzNnFadDJPMCtpNnlSbUZKNUxsdm52UUJ2M3YrR2NLV1Iw?=
 =?utf-8?B?ZVcraGlDaitGd29DOEdlVG1qR2VzOHFBV3BrSUI1cElUSVhWcisvbnNreUt1?=
 =?utf-8?B?T1M2QlBSa2dxakxTQmptZlhOcTJJdnlxOFFSNXBObTRua3hRbVNSTHJpb2Rq?=
 =?utf-8?B?OCtiYXNKd3FmU0l4R2VmSHBRZDIvU2NnVTd3NkRtUk53anNaaE9zbU5QNnVl?=
 =?utf-8?B?SFUrL2orVFFGNDI5cUJxSW54TStiQnVVZDM0L0pKK0JmRDBjMjZkblAyYVho?=
 =?utf-8?B?SkpWNlhWLzZnbGYvUGZUcS9rM2F6UFFpR0xLQW9CUkQ4L3BkWXhXUlhtTnlm?=
 =?utf-8?B?NGs3ck95U28ybmR1QVRpYmZIbUJCdG5tWTl4ZXlmK0g5WlZoNUV4aWMvZjZL?=
 =?utf-8?B?WFZwUUpsOHpTRXVMSm55YnhjVnQwY1F6TWlFTS9GZGRnQVFiU05nNVlOMFd3?=
 =?utf-8?B?ajJIY2h4OVRKbUMrZndXNVNmUFB4M1p5QnI2UlR5Yk9VK2VWYWpoMW82S2Fo?=
 =?utf-8?B?TVZHV2ZKYzhpTUw1aE9JdTJsZ2ZVYWc1WUZEZit5THBDVFl4RlhMSmkzREVB?=
 =?utf-8?B?ZU1QRWZzVElsM3lsTEdPSXQyMmNMd3AyTGZleG1uSXA1S3lvZXJoVVJrbFF6?=
 =?utf-8?B?WmpXYWNLNDV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU1FY01Td2kxSWZ3cTl1cnFWS05MV0h4UVMwcEdDUnhhYjY0SDRlZ0pGYlZB?=
 =?utf-8?B?ZnU0MEdTMHZiUk5GNVZqcTNXSmRTS05RejEzQ0dlb1A2azdCaXM3YlNpTThp?=
 =?utf-8?B?ZXVrL0VxaFRHL1hZNWtLalhXQjd3MTV4T0RBZ2JGRFN2a3RPUzV5cGs0MzNy?=
 =?utf-8?B?MlQxV2U4dVY3dlVsZEhud3pTUnU5NkZUM09qczdncnl6YTN5OTUxNUMvL0xR?=
 =?utf-8?B?bXBGRTQzakJCeXJPRVJPb1lxVlAvTUlXQmpWNGhjT1lGYmxlUFI0bFE2SDQy?=
 =?utf-8?B?V1pscXFDL3hua2FjWUFBdlNGdXFQTFVGTUpvb1VZQ2x5cDExWUJqZy9PUlcy?=
 =?utf-8?B?bTBzTUxKL28xVmJJWkdNV21qMGdVNHkxVHRzSjBVTGl3WWxPYzNNV1plcCtm?=
 =?utf-8?B?aU42MTlseUFyY04zV0VhMDFWcXcxTGdIWGRBa0RTV3FXZ3RIenN2elF0Q2Ny?=
 =?utf-8?B?MkZiVzJnbWxHWHh5VjAzTVZZcWJiQ2RuRjdLZGRSY0d2ODhGMzhkZWh3Y202?=
 =?utf-8?B?REJ1aHBwc3VxNVNRazhuOWRRcG15ajE1NThsYmMrdmxydWRES0pPbnJncEsw?=
 =?utf-8?B?YkN2RW1UMDBDcFBrWWwwUUtMWHBRdGVvZm1STkV3cTFMTWNpMjVwZFlqU0JT?=
 =?utf-8?B?OC9IYUF6SXdsNWhrNUREb1RMakt6RU5OU1pvNjNGUWFub1dFR3NVeTNIWDRC?=
 =?utf-8?B?cm5jVys1SHlCYVREYmhNSk9VY21qVWNIY3d6RXVXMUFCbGNNeDNNcUMxZGE0?=
 =?utf-8?B?ZzZ4SUR0Y3QvOVgwakkvUlpEakZsUWRUTlh1Ny9sWkpqZTF0eFJNdTlNbXBr?=
 =?utf-8?B?emRpYWhESjhDellqRUVwUUo5S3FEWGNxbHlvMW5CS2ErOE5nYTVRbjl6Zmlr?=
 =?utf-8?B?WkU3aTExT2dZSDVHeUs2L2YvbnVabWlkTk9oZ0RaelovNGxRakVUOUdrWFlL?=
 =?utf-8?B?RmRuaDdYc2dha2lVak5hbG84U21tbkdrTDlQM0t5V0JvKytZZnR0OHJzL2Fr?=
 =?utf-8?B?S1Y0RzdDaGV2ampYaWhNR1M0NmdDWWxocThsMzFtRUtVUDVJZm9zVStXTmEy?=
 =?utf-8?B?b3VtdjVCYm1IT05RUWY5cmVmVW82VVM4RktwMlFTenBVbXZ3SzhEOGdxVVZv?=
 =?utf-8?B?UVlOYUJLc1NaZ045QUJYc2dRaVltNmJoZHRPYlVtbElvTXF1WGlVS0ZDcVNz?=
 =?utf-8?B?RjlMY0hheEpYM05lWS9OSFdta1J4NENORm1OWmhtY2svZUVSdHE1TkxRTk5H?=
 =?utf-8?B?UU51aW15ZHVBaGJFUWxhOUIrU01PNityWGdVcGxjVDlEZTNtMnVXQU5teUhv?=
 =?utf-8?B?OHdBQ00rdVA4N0lRWU5FQkY0T2RnR0dQaTB6aHhPVzg5dlBWTWhBdkpmbWs2?=
 =?utf-8?B?WGI1dGRCbmRvMmZDL05LVTZCcXMwR1MySW40MnBqYTV5ZXFwdkZIQmRUbXhv?=
 =?utf-8?B?K3hFYWkvZ1lYNzF6QzU2dHlWQkNMWE9FU0crcWg2ZEp4QitlT3N5VElSeVR2?=
 =?utf-8?B?UmdWUEFSVFlldkNpd3hVcVNOZ0JXUFFYSUd1TXZIQ0x2c3lnbkNTdmVzaVll?=
 =?utf-8?B?QUVFNzFmSUF4b2pBd3lJbGszY2Rmc0dmcWd5TDEyOUhhYkVucUoxNUJudXdi?=
 =?utf-8?B?dnJTZEpzUTdlMFJUYkFtSGdRcldXZkdKaGtYc2FiaVcya0E5d3FLS1MrTEhs?=
 =?utf-8?B?eHBHQWxaRG1RQ3dGZVBXUmp0WVVQMU5wRjliS1QzUFdzYUxqUmdBL3NOMjl2?=
 =?utf-8?B?aklkcEhtYlRXMnVFdGlCQm1EcVBLazFyTjd3akxZa3ora2dDMHdaWHRIUkQx?=
 =?utf-8?B?SEs2OG1TZ2MvbElnQ2dOWWxEY3REdWRoMEdEUGFzc1BqdVRFZ3Naa3Q5aFFI?=
 =?utf-8?B?M1pKSEtOUWtLTVNvbkdnazRUTzNhSS9DKzMwMjNINlE3bWhNV1lwZGN2OEg2?=
 =?utf-8?B?enQ3Qm9sbGlQL3A0SFFZVDZjRithVzkzekRHOURheDBHVHdkMGNMdUhhMHNh?=
 =?utf-8?B?Sm9yNTFoeEJEOXlkeXl6Zy93WlNQakVnaDJDdE1iRnFJUW5BY3g5Q200WmhW?=
 =?utf-8?B?OGFDanRFY1BTOTJ5RWQzMGwyL0tWOUhJTEhkeE5QQzgxclZiTjRLMjk5WUk5?=
 =?utf-8?B?dWZFUlpackFJT2hwVktnOTVYeUhYa0FpVkxGemFLZ3NMOTVDWStZUC9HTmFm?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA597372CA0AE40A7701E764DD848FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566968b7-0cbe-4831-2643-08de26ded91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 20:12:50.0111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+VRhHE9jKkhuiZGo15vFhWkrp1/6+/mOpT5O+WGHU7CBkIn/qMY400EaQ2yUFxBHu+Bw9kJJMt79rwhDnsUvKS1xEulMW6ZtqHpTKi2ghc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTExLTE4IGF0IDIxOjA5ICswMTAwLCBNaWNoYWwgV2FqZGVjemtvIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDExLzE4LzIwMjUgODo1MCBQTSwgTHVjYXMgRGUgTWFyY2hpIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgTm92IDE4LCAyMDI1IGF0IDA4OjI5OjA5UE0gKzAxMDAsIE1pY2hhbCBX
YWpkZWN6a28gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gMTEvMTgvMjAyNSA4OjA4
IFBNLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6DQo+ID4gPiA+IEFkZCBtaXNzaW5nIHN0YWNrX2Rl
cG90X2luaXQoKSBjYWxsIHdoZW4NCj4gPiA+ID4gQ09ORklHX0RSTV9YRV9ERUJVR19HVUMgaXMN
Cj4gPiA+ID4gZW5hYmxlZCB0byBmaXggdGhlIGZvbGxvd2luZyBjYWxsIHN0YWNrOg0KPiA+ID4g
PiANCj4gPiA+ID4gwqDCoMKgwqBbXSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UsIGFkZHJlc3M6DQo+ID4gPiA+IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+ID4gwqDCoMKgwqBb
XSBXb3JrcXVldWU6wqAgZHJtX3NjaGVkX3J1bl9qb2Jfd29yayBbZ3B1X3NjaGVkXQ0KPiA+ID4g
PiDCoMKgwqDCoFtdIFJJUDogMDAxMDpzdGFja19kZXBvdF9zYXZlX2ZsYWdzKzB4MTcyLzB4ODcw
DQo+ID4gPiA+IMKgwqDCoMKgW10gQ2FsbCBUcmFjZToNCj4gPiA+ID4gwqDCoMKgwqBbXcKgIDxU
QVNLPg0KPiA+ID4gPiDCoMKgwqDCoFtdwqAgZmFzdF9yZXFfdHJhY2srMHg1OC8weGIwIFt4ZV0N
Cj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVzOiAxNmI3ZTY1ZDI5OWQgKCJkcm0veGUvZ3VjOiBUcmFj
ayBGQVNUX1JFUSBIMkdzIHRvIHJlcG9ydA0KPiA+ID4gPiB3aGVyZSBlcnJvcnMgY2FtZSBmcm9t
IikNCj4gPiA+ID4gVGVzdGVkLWJ5OiBTYWdhciBHaHVnZSA8c2FnYXIuZ2h1Z2VAaW50ZWwuY29t
Pg0KPiA+ID4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTcrDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIERlIE1hcmNoaSA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29t
Pg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMg
fCAzICsrKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMN
Cj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMNCj4gPiA+ID4gaW5kZXgg
MjY5N2Q3MTFhZGIyYi4uMDdhZTBkNjAxOTEwZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3hlL3hlX2d1Y19jdC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94
ZS94ZV9ndWNfY3QuYw0KPiA+ID4gPiBAQCAtMjM2LDYgKzIzNiw5IEBAIGludCB4ZV9ndWNfY3Rf
aW5pdF9ub2FsbG9jKHN0cnVjdCB4ZV9ndWNfY3QNCj4gPiA+ID4gKmN0KQ0KPiA+ID4gPiDCoCNp
ZiBJU19FTkFCTEVEKENPTkZJR19EUk1fWEVfREVCVUcpDQo+ID4gPiA+IMKgwqDCoMKgIHNwaW5f
bG9ja19pbml0KCZjdC0+ZGVhZC5sb2NrKTsNCj4gPiA+ID4gwqDCoMKgwqAgSU5JVF9XT1JLKCZj
dC0+ZGVhZC53b3JrZXIsIGN0X2RlYWRfd29ya2VyX2Z1bmMpOw0KPiA+ID4gPiArI2lmIElTX0VO
QUJMRUQoQ09ORklHX0RSTV9YRV9ERUJVR19HVUMpDQo+ID4gPiA+ICvCoMKgwqAgc3RhY2tfZGVw
b3RfaW5pdCgpOw0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPiANCj4gPiA+IHNob3VsZG4ndCB3ZSBq
dXN0IHVwZGF0ZSBvdXIgS2NvbmZpZyBieSBhZGRpbmcgaW4NCj4gPiA+IERSTV9YRV9ERUJVR19H
VUMNCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqBzZWxlY3QgU1RBQ0tERVBPVF9BTFdBWVNfSU5JVA0K
PiA+IA0KPiA+IGRpZG4ndCBrbm93IGFib3V0IHRoYXQsIHRoYW5rcy4uLi4gYnV0IHRoYXQgZG9l
c24ndCBzZWVtIHN1aXRhYmxlDQo+ID4gZm9yIGENCj4gPiBzb21ldGhpbmcgdGhhdCB3aWxsIGJl
IGEgbW9kdWxlIHRoYXQgbWF5IG9yIG1heSBub3QgZ2V0IGxvYWRlZA0KPiA+IGRlcGVuZGluZw0K
PiA+IG9uIGh3IGNvbmZpZ3VyYXRpb24uDQo+IA0KPiB0cnVlIGluIGdlbmVyYWwsIGJ1dCBoZXJl
IHdlIG5lZWQgc3RhY2tkZXBvdCBmb3IgdGhlIERFQlVHX0dVQyB3aGljaA0KPiBsaWtlbHkgd2ls
bA0KPiBzZWxlY3RlZCBvbmx5IGJ5IHNvbWVvbmUgd2hvIGFscmVhZHkgaGFzIHRoZSByaWdodCBw
bGF0Zm9ybSBhbmQgcGxhbnMNCj4gdG8gbG9hZCB0aGUgeGUNCg0KQW5vdGhlciBjb3VudGVyYXJn
dW1lbnQgaGVyZSBpcyB0aGF0IGRybV9tbSAoYW5kIGV2ZW4gY29yZV9tbSkgYXJlDQpleHBsaWNp
dGx5IGNhbGxpbmcgdGhpcyBkdXJpbmcgaW5pdGlhbGl6YXRpb24uIEFuZCB3aGF0IGlmIHdlIGRl
Y2lkZSB0bw0KYWRkIGFub3RoZXIgdXNlIGNhc2UgaW4gWGUgZm9yIHRoZSBzYW1lPyBTaG91bGRu
J3Qgd2UgZm9sbG93IHRoaXMgc2FtZQ0KYXBwcm9hY2g/DQoNCldlIGNvdWxkIGFsc28gZG8gYm90
aCBoZXJlIC0ga2NvbmZpZyBhbmQgaW4gY29kZS4gQXMgbWVudGlvbmVkIGl0DQpkb2Vzbid0IGh1
cnQgZ2l2ZW4gdGhlIHdheSB0aGUgc3RhY2tkZXBvdCBpbml0IGlzIHdyaXR0ZW4uDQoNClRoYW5r
cywNClN0dWFydA0KDQo+IA0KPiA+IA0KPiA+IEluZGVlZCwgdGhlIG9wdGlvbiAzIHNheXM6DQo+
ID4gDQo+ID4gwqDCoMKgwqAzLiBDYWxsaW5nIHN0YWNrX2RlcG90X2luaXQoKS4gUG9zc2libGUg
YWZ0ZXIgYm9vdCBpcyBjb21wbGV0ZS4NCj4gPiBUaGlzIG9wdGlvbg0KPiA+IMKgwqDCoMKgwqDC
oCBpcyByZWNvbW1lbmRlZCBmb3IgbW9kdWxlcyBpbml0aWFsaXplZCBsYXRlciBpbiB0aGUgYm9v
dA0KPiA+IHByb2Nlc3MsIGFmdGVyDQo+ID4gwqDCoMKgwqDCoMKgIG1tX2luaXQoKSBjb21wbGV0
ZXMuDQo+ID4gDQo+ID4gU28gSSB0aGluayBpdCdzIHByZWZlcnJlZCB0byBkbyB3aGF0IHdlIGFy
ZSBkb2luZyBoZXJlLg0KPiA+IA0KPiA+IEx1Y2FzIERlIE1hcmNoaQ0KPiA+IA0KPiA+ID4gDQo+
ID4gPiBpdCdzIHRoZSBmaXJzdCBvcHRpb24gbGlzdGVkIGluIFsxXQ0KPiA+ID4gDQo+ID4gPiBb
MV0NCj4gPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE4LXJjNi9zb3Vy
Y2UvaW5jbHVkZS9saW51eC9zdGFja2RlcG90LmgjTDk0DQo+ID4gPiANCj4gPiA+ID4gwqAjZW5k
aWYNCj4gPiA+ID4gwqDCoMKgwqAgaW5pdF93YWl0cXVldWVfaGVhZCgmY3QtPndxKTsNCj4gPiA+
ID4gwqDCoMKgwqAgaW5pdF93YWl0cXVldWVfaGVhZCgmY3QtPmcyaF9mZW5jZV93cSk7DQo+ID4g
PiA+IA0KPiA+ID4gDQo+IA0KDQo=

