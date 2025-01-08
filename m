Return-Path: <stable+bounces-107928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C9A04DFF
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC451887EE5
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE72594B3;
	Wed,  8 Jan 2025 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im/veeOl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05A5228;
	Wed,  8 Jan 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294546; cv=fail; b=U5JGO2jvLPDPQvVdPghWMr+Pow2vpZPBNC5zd+6S3HDTn0bL7VB51CCBtv7+5gs367uweNwhEpvAPX7+GRp+nELlO0jqwDkxHodR48CrIFgVbVoYvvW/RQ66KBzPfaHEuw0gX2kjeaEqhppJgwIdBP4YKMKXhYfYehE3PoGJyBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294546; c=relaxed/simple;
	bh=mN/UntUfSv4s82clCJW6T63FfG+sx2oy5e2MmFfYIno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jshCdru3lMnPmbdgaRtPkm2Kh7qtD2q32oHaUuExduIWkMUFZXE4kG3KvJ4tk/hener0bwZTP0865rm13+cifiVbmusbAXo5M96j1wJAKx7/IzhO75bHZRq5OOusCjWRVWv5ZJzlUncKT0q+yH7HSIM2DpajDBixlUqH/zbhwlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=im/veeOl; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736294544; x=1767830544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mN/UntUfSv4s82clCJW6T63FfG+sx2oy5e2MmFfYIno=;
  b=im/veeOlIfkC219gxeP64luRJezEmAWOewzP8AmTb+ffqwNTeTlavenE
   lEx7I4upJ8PwgM4sXTkPYgszhp5W79w8/arP+/gzAeBV+9+DAHzyxgqPH
   0qLF7lIbrieuVNUhZqq6278jQXWnfcpXNOuP7JcqxacKAG3yNDQv81x2p
   RjPsH3SJT837tt5pGrV/QRxyj661L2eENFx6bTL0k7F9TVUXdopyDKSUN
   PDARCVPYilj2HPJSC2kKV3bQlnmnUQ4NaSjU1t8T3+5h5Bf0JrvYbdSoP
   bAZRWPZ8ORyxCFguM3XQbavZ5ubtaDb9d73CeFgI+EqN7dqzyU+/j/Bog
   g==;
X-CSE-ConnectionGUID: dqbN5rZGRzCc64eXJ8We9Q==
X-CSE-MsgGUID: B4c1jMCsTKmAap26KwPWAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47080027"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="47080027"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 16:02:23 -0800
X-CSE-ConnectionGUID: sif4UnpHQ9uaXrP7Z8vsyQ==
X-CSE-MsgGUID: xOlYJ5TpQ52nklJh3QAjmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103764027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 16:02:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 16:02:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 16:02:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 16:02:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4peX1FPR/aG57MfZgQ8ov9n6fyKvQOnwR6F+Qrh7Ti9lmgJ75K4yK8ESjUthpyXjX09+a4KgBBchPZAQun8tAj3U1H6ACbQGj0O6ie4483Voa5FnMtk1PxHSmRVTYI5ijb+Fuge4ka/5i8BjSuqQc7mrRbPWYcswzIntBatOYnsaUBlWgKpgBEzp7Lxqcqi+34ZIgZGXalxdDSG283gKrpyaBYgO3I8sVyb5ndVuvUOgzULO8lPIR8uqFUd/virlVe1B91MQw3+lfXfsbYWW2fgbuHcCs6ZmPyMBM1Spo1FbuexB5RZorPEXVuvDfvE4xgXt2o6XkksByyxqfYQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN/UntUfSv4s82clCJW6T63FfG+sx2oy5e2MmFfYIno=;
 b=QDnGJPqKblcCVAB7aBH67oJ6byLv5ECEOBudECBdhgFcN5aiYUBBuuUIWOEbj0nsUWklZWcoNOmVkm1bkrVjo6MB0BA0m/0aIPJFnKxfT0sAH9OVM/soCQT7vALI081AQodzqfSbzI2BHWVlrDq0Y6CNR0QCktmqFVNnb6TDZyCuGZc87RBce7ATpMQ+YiwvjQgqb7mUYXHPYqSG31v77WkRAkI6OIqlFMgJtixdZ3oA5TJMlVcahBh9Z5X4sFsI3QIHdAx/vv5FnHSv9Leprw9UyFbvXAnNwKZekEd1DCgXBFxxbFVPddShMLEe13bQQWc5QgbxbZqhQl3deEThPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) by
 DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Wed, 8 Jan 2025 00:01:59 +0000
Received: from DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641]) by DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 00:01:59 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool
	<vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, Sam Sun
	<samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
Thread-Topic: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
Thread-Index: AQHbYVK3SB8LCS0pNE600ZzlkbZ21LML97zg
Date: Wed, 8 Jan 2025 00:01:59 +0000
Message-ID: <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com>
In-Reply-To: <20250107222236.2715883-2-yosryahmed@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5671:EE_|DS7PR11MB7781:EE_
x-ms-office365-filtering-correlation-id: a2be3b87-c51e-4cbb-9ee5-08dd2f77ac11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cysyMFhGUFdXR2Zac1lRU2paMnloWWxoam1oK0k4a2xNU2xOQVZPa2VIcXlF?=
 =?utf-8?B?WXhaT3krT2o0am10SUZ0eExvbC9ienF6SUpURlg5Z0MzVEdWMlJRam5MRFlF?=
 =?utf-8?B?Zk5IK3ZOdDVEaitueVV5SWF5cWxQMjZpcFpOdGx3SjdhNlJTbzl5MFBnMWNP?=
 =?utf-8?B?alpmK3V5MDFzVGcxYXhMd3BPelhXNmY0MzNPRHJnK21yMlVFYXlLOGUxM2xy?=
 =?utf-8?B?eWtjV1hDa3B1WTE0OTdDTnFSY0VNdUJaYzlTZlJhbzA4YUNnQTJqUzJSSlh2?=
 =?utf-8?B?U0tlWU56MUZKZHduM1NJTWwvVUorQi9QaWIrS1VxWE1jMDZ0RWp1QTBTR0JN?=
 =?utf-8?B?V09BcitCOE54cXFFNGZMdG83MkxLQXhrTWkvaUpuTHkrdE1RMWR1Kzc0WTI0?=
 =?utf-8?B?MWJLYVhVWUVqZzh6bGNmMWx5UVhSQldVWlBaSzU2ZGFSM0VyU2FwZmJYck1B?=
 =?utf-8?B?bCt4K3MxcTZqdDVxbTYwc3h4bXUrNDhqTUJTNm4rSUkrY0I2dlFCcU5teXhE?=
 =?utf-8?B?Zk1tajdKbnZmbGhtNUFuVHZEZlFLdjN6R1NjL3Ztc0pRVUw5V2VhUk5mUkFU?=
 =?utf-8?B?VG81NVFEZTVFelBrZHpKOG43NE1xYmR3QzNsb29uZk1wZjlpMTRidzlvREEw?=
 =?utf-8?B?S2RuM21BWjg0TzZzL0dxUFJsYk5NdDllTll6cElselNVUXFlM09XK2lxU2lK?=
 =?utf-8?B?bko2VHlVNC9NcUZjTCswZE9GNFlVVVV0RWYvWllVeWpSZzhBeEJBYU1TZnB1?=
 =?utf-8?B?aVZGYkZNTFpkQ1Q0MW5lS2lZYzJhOG85d2ZqejFkVUhubysxaWhOdzBaRGJC?=
 =?utf-8?B?QTdRbHVvU044TXVOdExYSm5ka1hFTUFWQXI5cmZ1WjhkSVB0cCtTcEZkZS9a?=
 =?utf-8?B?bTF5U0ZUZ2NmU2pBQ0s2eFZaREo3TVExWnNMQVhVcUc5QU5qY2E0U0lhYWlC?=
 =?utf-8?B?SmxLQjRLaUdXaWhEMEE4ZUVpSlJSbURzY2FKWUVDWWtsUHFqR3JBd0NUaGYw?=
 =?utf-8?B?a1VMWlFOaU9RQ0VsQ2JRa1dyVDNmV0Q3S3dYZEdIS2tNQVQrQkxuZDBpOE1t?=
 =?utf-8?B?eDZEQXEzdW9DSDFvRjdOZXdoWjFkcndNR3hnSVgyTm5DY0IvaXN1YlQzWnFa?=
 =?utf-8?B?b1dtMndXS296cnZBaWJUYjBJZTFmbFo5bFY0WE96dVAwN0JIbjNNTDlMVE4y?=
 =?utf-8?B?RDN2cjdaaUJsYk93R3E1dUJXTkFrb0NwajFrQWovV0o5Q01RcWd6WUkxRVE3?=
 =?utf-8?B?aHQ1aEtOMFlCTWMzNGhmNVRBQWo5TlE2VGRzUzBsSGV0SjVsSzlDKzdXb1h6?=
 =?utf-8?B?ajdzWEtIV0ZXUzh3MVk3eDRXcnI2RUZTa1FFdFhlZkJPWlhxVCtnZWRUNkVs?=
 =?utf-8?B?RXh0aEpUbVBzekRMdC83cE9yMFFHYTdEbEZ3VjhTVmpwVjBvTEpsQ25UN2NF?=
 =?utf-8?B?SU95ajBCS3JiTy9XZGxBUWpOakJCUEVNS0pyVlZLZzIzSGp2WVRZUllxRWRJ?=
 =?utf-8?B?WE5jYWFON1I1aDVVdStJZDFvaGtVSFlZaE1pbG9Ma3kwQlJFMDB5YnRrakhS?=
 =?utf-8?B?WDFHOHBsQk5BTzRsbmp3SjYxdy9jZnlFQ01BQzRmbnVCa05jVmlFTTExdVFt?=
 =?utf-8?B?WWoya2xEUzY1VEsvbFB6VG5NT1BCRktSR29icFh4K1hrVFFZc1dqRVUvL3FY?=
 =?utf-8?B?Y3Z2RHdkVTZOaU8vc1U1S3lSYWVpaWJlNFJVWSsreUI1TmVoeHRmeEFQT294?=
 =?utf-8?B?U1V5bmNWYTVrNjRtK1UrWG9ab1h5YVJwRm1ESmJiMERoWGtmRmYrd1JKS2Ew?=
 =?utf-8?B?enNBejVlb1RYTHhTTkM2dndjNUdRbkgrOWw4RTBNZzVMbHo5UTVRVWJtUEov?=
 =?utf-8?B?OTcvQWo0aG1SVTNkeE1UTmVVU0kvN3grQ1NxRE5Hc25Ba1JsaC9rU3lNUGFS?=
 =?utf-8?B?Rzc4aWtBcHk0SHI5WmJtUWVveUpLWGNlMnp0Si9zSVZBMnRmTVVHcmlWRVpO?=
 =?utf-8?B?cTgwUjExZHR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEdkZ1JlaDlPNTF2a3Y4Tk1wMmV5ZWQ5bHFmQ2ZFeXdydHNnZmJocHhCOVVC?=
 =?utf-8?B?emJRUDdES1pMZUZyUE9oaWRKeFpTdXNNc3ZUdGFrVUFKT2k3RmU5Wjh2UStt?=
 =?utf-8?B?TDVscUhZQzVlMVRxeEQ4dG5rTUpaWjRtZmJXYTVnR2RVRlBGRlRjdmluUjU2?=
 =?utf-8?B?WlFZZlhYTmZPZmluZEdkbDF6SHh4SEVqQUwwbHhjb054Vk45b1JpelNkTW1z?=
 =?utf-8?B?aFFQSlBTZ25zNVZDeE5hVmNwOEtVMlNMUXA3OHhVclltQzFEQmppbk1GQjFB?=
 =?utf-8?B?Q2ZWNGRzQ3NEelVLMWpHc3gvUC9TWFlBODlydXVHV0NWVlhZQjNMTG13dkxt?=
 =?utf-8?B?VDBYc2VBYk85ZzV5ZEFYUXo3NGkxU3AvbG5qN3pma1dkaEhsY2F1d0ZWaWhO?=
 =?utf-8?B?cVNXRGthS0drclBFa2hqSXZKOFJxU0NLbXE5OGNiWkptbVR1STNaK1F6eUZp?=
 =?utf-8?B?UlNNSmNscHpjK1F1MGx0M3BYbmxTL0ZUVThVQ1BGVkRuTFg2R2V4ZElMb2JX?=
 =?utf-8?B?clNFRnVRTEZXV1ZxQ29kUjdVejFvSG5jb0tHN0tPZ28wSXpOS3kydHkrbCtp?=
 =?utf-8?B?UkhDem4vK3ovdVBnU1NPeHVHTFNVVmVsVzAxTWRMOGw4alYvWHpGRXNRMkI3?=
 =?utf-8?B?dThOa0FGR3dPUEtoN1hrTytHN3psTE1hRHFOUjM1U29pcnh1QmM3TThTZHdh?=
 =?utf-8?B?ZjVlQUc3emVmQ2MrS3VDdVRBQkdCY25VaUJvOFVkTWZwSkJOSnVrcEViWHhW?=
 =?utf-8?B?Vm94SFIxanpWMEFuS2tFeGFUdDFTZEFRR1hzcXpHV3dkTXgwdDVBMHhmNmZM?=
 =?utf-8?B?dFFuMXYrcVZCSmJsczY3bTFlSVEvSE5FbGEremZxN2QycWNXK2pBbDF4RzFu?=
 =?utf-8?B?bmhyd1FwdjdoRDl1NVlOZ1I3UjErRjZGNEJOYXNMenRxN1hnNjFGTUk1Y29Z?=
 =?utf-8?B?cjJBVzlDZHVFNXErL09tWTZCdWNoMjVNd2NjZ3lWemRHOUt1YlVjZDkwM0py?=
 =?utf-8?B?OUQzbU8rNlo4UnkxM0hjQ1NiT0NLWURTd3JiUWNUQjBjeExIdUgzMVJsZys5?=
 =?utf-8?B?RStXRXlFZkVLT3VGZXhlZHpFakVxeE43WUFSL2NlWS9SNUIveEhUZHdpM091?=
 =?utf-8?B?eU11cEQzZi9YZ2orbWlLNHQ4Y2ZDa0VDQUJ0N1dNbzZtTWduTDhvakpodzZ5?=
 =?utf-8?B?OVpYRnhPOEFDSkdDcVIwWHhabEN6Vy9JemdtUjZJbCtLMlA5UTMxMmRUQ29w?=
 =?utf-8?B?aU1QSk5wbFVSb0hpVjkySWRMSXlwQ0pmQTI4THU3UC9ybElnWVN2ZzdsTTlj?=
 =?utf-8?B?ZzcvNHYvVkFDc1laU0hkaEY0ZDJPcUlrbVBwV2JISysxeSthTGhCY3Vhcmps?=
 =?utf-8?B?S2I5R0NCOXRmaE9EK1FvSlE0UWhSRlpXVmlsTUZaUmlxQ1dxUEhXWlp6RnpJ?=
 =?utf-8?B?RSswUFlranF6Y1N2RmxFWG9VNmh2NmJrVUU3cGRseW5nMzdFd2MvNVZWYlk0?=
 =?utf-8?B?UGdMNmIxMjdHcmZCTnpXSEdGNU9WNDZXTURqSDBTZUNab0VoL3NtZTkxZGw5?=
 =?utf-8?B?SlRQTmcwcXBGMkhYayt2YTNHeHFaRWVGUW1hcFMvdGF2UG9NWVNuc1hoT3c1?=
 =?utf-8?B?ZWxqdnhqekQzVXR3VkhiQzZ1QldJNG51Z1NBNkRYVUVVYkRsRlk0aXRRdlU4?=
 =?utf-8?B?SVA1aHlnZmhhUHhuc01reG1SbHdtR0hvMzNKYnNlallsV0FFYTgzc0RxR2Rn?=
 =?utf-8?B?NDJJblpsUDR6M1FCZS8zcDdUOW0zV1pIUWhSTXgwMktMUm9RY0VzaGlNanlO?=
 =?utf-8?B?WkxYYVg2OUZveElGWGx5UUpNNlpJNWF4c3ZWK3V4ZjV6VVl1Tks0eDNoR1Rq?=
 =?utf-8?B?MHFmUGUxTUVMb3pYU0FwWVRlZXk0RlhJWWhSOHlkSElBcytOWDVvTWtKYjYy?=
 =?utf-8?B?Z3BWdE82aG85MTR6UVhVZVZkQjhCTCtaN1RvS293MlZhdjBQWmFtUG5sNXdM?=
 =?utf-8?B?Y2lhWXRHcEZIT0M4QkZ6elpSM1g4K1hOWU1xL0ZiRHM1dmpTelRFS0pmTUgz?=
 =?utf-8?B?bDFUdklYK3BnU2NCbWc0dnBVWlNqS3FaaXQ4VS9ycmJHZ0ViWnFDT0FINFgr?=
 =?utf-8?B?cS9IVE5ROVBlN1RWejVyN2djVGZqZUlERzJjbk9KTi9wZGJtdjJVdHZ6ZU1w?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2be3b87-c51e-4cbb-9ee5-08dd2f77ac11
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 00:01:59.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JD0AcQo2/Ffx7IaFCdfDUo41Xp8JywxYjXbYLJ7mHdBaLROi/YbF+IvGrzw/I12p7JMDq7cBb3fEn7mNvLGAhakAXh78hTUfLKOMJ8Lcywc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA3
LCAyMDI1IDI6MjMgUE0NCj4gVG86IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmc+DQo+IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz47IE5oYXQg
UGhhbQ0KPiA8bnBoYW1jc0BnbWFpbC5jb20+OyBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpo
b3VAbGludXguZGV2PjsNCj4gVml0YWx5IFdvb2wgPHZpdGFseXdvb2xAZ21haWwuY29tPjsgQmFy
cnkgU29uZyA8YmFvaHVhQGtlcm5lbC5vcmc+OyBTYW0NCj4gU3VuIDxzYW1zdW4xMDA2MjE5QGdt
YWlsLmNvbT47IFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsNCj4gc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8yXSBtbTogenN3YXA6IGRpc2FibGUg
bWlncmF0aW9uIHdoaWxlIHVzaW5nIHBlci1DUFUNCj4gYWNvbXBfY3R4DQo+IA0KPiBJbiB6c3dh
cF9jb21wcmVzcygpIGFuZCB6c3dhcF9kZWNvbXByZXNzKCksIHRoZSBwZXItQ1BVIGFjb21wX2N0
eCBvZg0KPiB0aGUNCj4gY3VycmVudCBDUFUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgb3BlcmF0
aW9uIGlzIHJldHJpZXZlZCBhbmQgdXNlZA0KPiB0aHJvdWdob3V0LiAgSG93ZXZlciwgc2luY2Ug
bmVpdGhlciBwcmVlbXB0aW9uIG5vciBtaWdyYXRpb24gYXJlIGRpc2FibGVkLA0KPiBpdCBpcyBw
b3NzaWJsZSB0aGF0IHRoZSBvcGVyYXRpb24gY29udGludWVzIG9uIGEgZGlmZmVyZW50IENQVS4N
Cj4gDQo+IElmIHRoZSBvcmlnaW5hbCBDUFUgaXMgaG90dW5wbHVnZ2VkIHdoaWxlIHRoZSBhY29t
cF9jdHggaXMgc3RpbGwgaW4gdXNlLA0KPiB3ZSBydW4gaW50byBhIFVBRiBidWcgYXMgdGhlIHJl
c291cmNlcyBhdHRhY2hlZCB0byB0aGUgYWNvbXBfY3R4IGFyZSBmcmVlZA0KPiBkdXJpbmcgaG90
dW5wbHVnIGluIHpzd2FwX2NwdV9jb21wX2RlYWQoKS4NCj4gDQo+IFRoZSBwcm9ibGVtIHdhcyBp
bnRyb2R1Y2VkIGluIGNvbW1pdCAxZWMzYjVmZTZlZWMgKCJtbS96c3dhcDogbW92ZSB0bw0KPiB1
c2UNCj4gY3J5cHRvX2Fjb21wIEFQSSBmb3IgaGFyZHdhcmUgYWNjZWxlcmF0aW9uIikgd2hlbiB0
aGUgc3dpdGNoIHRvIHRoZQ0KPiBjcnlwdG9fYWNvbXAgQVBJIHdhcyBtYWRlLiAgUHJpb3IgdG8g
dGhhdCwgdGhlIHBlci1DUFUgY3J5cHRvX2NvbXAgd2FzDQo+IHJldHJpZXZlZCB1c2luZyBnZXRf
Y3B1X3B0cigpIHdoaWNoIGRpc2FibGVzIHByZWVtcHRpb24gYW5kIG1ha2VzIHN1cmUgdGhlDQo+
IENQVSBjYW5ub3QgZ28gYXdheSBmcm9tIHVuZGVyIHVzLiAgUHJlZW1wdGlvbiBjYW5ub3QgYmUg
ZGlzYWJsZWQgd2l0aCB0aGUNCj4gY3J5cHRvX2Fjb21wIEFQSSBhcyBhIHNsZWVwYWJsZSBjb250
ZXh0IGlzIG5lZWRlZC4NCj4gDQo+IENvbW1pdCA4YmEyZjg0NGYwNTAgKCJtbS96c3dhcDogY2hh
bmdlIHBlci1jcHUgbXV0ZXggYW5kIGJ1ZmZlciB0bw0KPiBwZXItYWNvbXBfY3R4IikgaW5jcmVh
c2VkIHRoZSBVQUYgc3VyZmFjZSBhcmVhIGJ5IG1ha2luZyB0aGUgcGVyLUNQVQ0KPiBidWZmZXJz
IGR5bmFtaWMsIGFkZGluZyB5ZXQgYW5vdGhlciByZXNvdXJjZSB0aGF0IGNhbiBiZSBmcmVlZCBm
cm9tIHVuZGVyDQo+IHpzd2FwIGNvbXByZXNzaW9uL2RlY29tcHJlc3Npb24gYnkgQ1BVIGhvdHVu
cGx1Zy4NCj4gDQo+IFRoaXMgY2Fubm90IGJlIGZpeGVkIGJ5IGhvbGRpbmcgY3B1c19yZWFkX2xv
Y2soKSwgYXMgaXQgaXMgcG9zc2libGUgZm9yDQo+IGNvZGUgYWxyZWFkeSBob2xkaW5nIHRoZSBs
b2NrIHRvIGZhbGwgaW50byByZWNsYWltIGFuZCBlbnRlciB6c3dhcA0KPiAoY2F1c2luZyBhIGRl
YWRsb2NrKS4gSXQgYWxzbyBjYW5ub3QgYmUgZml4ZWQgYnkgd3JhcHBpbmcgdGhlIHVzYWdlIG9m
DQo+IGFjb21wX2N0eCBpbiBhbiBTUkNVIGNyaXRpY2FsIHNlY3Rpb24gYW5kIHVzaW5nIHN5bmNo
cm9uaXplX3NyY3UoKSBpbg0KPiB6c3dhcF9jcHVfY29tcF9kZWFkKCksIGJlY2F1c2Ugc3luY2hy
b25pemVfc3JjdSgpIGlzIG5vdCBhbGxvd2VkIGluDQo+IENQVS1ob3RwbHVnIG5vdGlmaWVycyAo
c2VlDQo+IERvY3VtZW50YXRpb24vUkNVL0Rlc2lnbi9SZXF1aXJlbWVudHMvUmVxdWlyZW1lbnRz
LnJzdCkuDQo+IA0KPiBUaGlzIGNhbiBiZSBmaXhlZCBieSByZWZjb3VudGluZyB0aGUgYWNvbXBf
Y3R4LCBidXQgaXQgaW52b2x2ZXMNCj4gY29tcGxleGl0eSBpbiBoYW5kbGluZyB0aGUgcmFjZSBi
ZXR3ZWVuIHRoZSByZWZjb3VudCBkcm9wcGluZyB0byB6ZXJvIGluDQo+IHpzd2FwX1tkZV1jb21w
cmVzcygpIGFuZCB0aGUgcmVmY291bnQgYmVpbmcgcmUtaW5pdGlhbGl6ZWQgd2hlbiB0aGUgQ1BV
DQo+IGlzIG9ubGluZWQuDQo+IA0KPiBLZWVwIHRoaW5ncyBzaW1wbGUgZm9yIG5vdyBhbmQganVz
dCBkaXNhYmxlIG1pZ3JhdGlvbiB3aGlsZSB1c2luZyB0aGUNCj4gcGVyLUNQVSBhY29tcF9jdHgg
dG8gYmxvY2sgQ1BVIGhvdHVucGx1ZyB1bnRpbCB0aGUgdXNhZ2UgaXMgb3Zlci4NCj4gDQo+IEZp
eGVzOiAxZWMzYjVmZTZlZWMgKCJtbS96c3dhcDogbW92ZSB0byB1c2UgY3J5cHRvX2Fjb21wIEFQ
SSBmb3INCj4gaGFyZHdhcmUgYWNjZWxlcmF0aW9uIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPg0KPiBSZXBvcnRlZC1ieTogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+
DQo+IENsb3NlczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTExMzIxMzAw
Ny5HQjE1NjQwNDdAY21weGNoZy5vcmcvDQo+IFJlcG9ydGVkLWJ5OiBTYW0gU3VuIDxzYW1zdW4x
MDA2MjE5QGdtYWlsLmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sL0NBRWtKZllNdFNkTTVIY2VOc1hVRGY1aGFnaEQ1K28yZTdRdjRPDQo+IGN1cnVMNHRQZzZP
YVFAbWFpbC5nbWFpbC5jb20vDQo+IC0tLQ0KPiAgbW0venN3YXAuYyB8IDE5ICsrKysrKysrKysr
KysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+IGluZGV4
IGY2MzE2YjY2ZmIyMzYuLmVjZDg2MTUzZThhMzIgMTAwNjQ0DQo+IC0tLSBhL21tL3pzd2FwLmMN
Cj4gKysrIGIvbW0venN3YXAuYw0KPiBAQCAtODgwLDYgKzg4MCwxOCBAQCBzdGF0aWMgaW50IHpz
d2FwX2NwdV9jb21wX2RlYWQodW5zaWduZWQgaW50IGNwdSwNCj4gc3RydWN0IGhsaXN0X25vZGUg
Km5vZGUpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArLyogUmVtYWluIG9uIHRoZSBDUFUg
d2hpbGUgdXNpbmcgaXRzIGFjb21wX2N0eCB0byBzdG9wIGl0IGZyb20gZ29pbmcgb2ZmbGluZQ0K
PiAqLw0KPiArc3RhdGljIHN0cnVjdCBjcnlwdG9fYWNvbXBfY3R4ICphY29tcF9jdHhfZ2V0X2Nw
dShzdHJ1Y3QNCj4gY3J5cHRvX2Fjb21wX2N0eCBfX3BlcmNwdSAqYWNvbXBfY3R4KQ0KPiArew0K
PiArCW1pZ3JhdGVfZGlzYWJsZSgpOw0KPiArCXJldHVybiByYXdfY3B1X3B0cihhY29tcF9jdHgp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBhY29tcF9jdHhfcHV0X2NwdSh2b2lkKQ0KPiAr
ew0KPiArCW1pZ3JhdGVfZW5hYmxlKCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBib29sIHpzd2Fw
X2NvbXByZXNzKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJ5LA0K
PiAgCQkJICAgc3RydWN0IHpzd2FwX3Bvb2wgKnBvb2wpDQo+ICB7DQo+IEBAIC04OTMsOCArOTA1
LDcgQEAgc3RhdGljIGJvb2wgenN3YXBfY29tcHJlc3Moc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVj
dA0KPiB6c3dhcF9lbnRyeSAqZW50cnksDQo+ICAJZ2ZwX3QgZ2ZwOw0KPiAgCXU4ICpkc3Q7DQo+
IA0KPiAtCWFjb21wX2N0eCA9IHJhd19jcHVfcHRyKHBvb2wtPmFjb21wX2N0eCk7DQo+IC0NCj4g
KwlhY29tcF9jdHggPSBhY29tcF9jdHhfZ2V0X2NwdShwb29sLT5hY29tcF9jdHgpOw0KPiAgCW11
dGV4X2xvY2soJmFjb21wX2N0eC0+bXV0ZXgpOw0KPiANCj4gIAlkc3QgPSBhY29tcF9jdHgtPmJ1
ZmZlcjsNCj4gQEAgLTk1MCw2ICs5NjEsNyBAQCBzdGF0aWMgYm9vbCB6c3dhcF9jb21wcmVzcyhz
dHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0DQo+IHpzd2FwX2VudHJ5ICplbnRyeSwNCj4gIAkJenN3
YXBfcmVqZWN0X2FsbG9jX2ZhaWwrKzsNCj4gDQo+ICAJbXV0ZXhfdW5sb2NrKCZhY29tcF9jdHgt
Pm11dGV4KTsNCj4gKwlhY29tcF9jdHhfcHV0X2NwdSgpOw0KDQpJIGhhdmUgb2JzZXJ2ZWQgdGhh
dCBkaXNhYmxpbmcvZW5hYmxpbmcgcHJlZW1wdGlvbiBpbiB0aGlzIHBvcnRpb24gb2YgdGhlIGNv
ZGUNCmNhbiByZXN1bHQgaW4gc2NoZWR1bGluZyB3aGlsZSBhdG9taWMgZXJyb3JzLiBJcyB0aGUg
c2FtZSBwb3NzaWJsZSB3aGlsZQ0KZGlzYWJsaW5nL2VuYWJsaW5nIG1pZ3JhdGlvbj8NCg0KQ291
cGxlIG9mIHBvc3NpYmx5IHJlbGF0ZWQgdGhvdWdodHM6DQoNCjEpIEkgaGF2ZSBiZWVuIHRoaW5r
aW5nIHNvbWUgbW9yZSBhYm91dCB0aGUgcHVycG9zZSBvZiB0aGlzIHBlci1jcHUgYWNvbXBfY3R4
DQogICAgIG11dGV4LiBJdCBhcHBlYXJzIHRoYXQgdGhlIG1haW4gYmVuZWZpdCBpcyBpdCBjYXVz
ZXMgdGFzayBibG9ja2VkIGVycm9ycyAod2hpY2ggYXJlDQogICAgIHVzZWZ1bCB0byBkZXRlY3Qg
cHJvYmxlbXMpIGlmIGFueSBjb21wdXRlcyBpbiB0aGUgY29kZSBzZWN0aW9uIGl0IGNvdmVycyB0
YWtlIGENCiAgICAgbG9uZyBkdXJhdGlvbi4gT3RoZXIgdGhhbiB0aGF0LCBpdCBkb2VzIG5vdCBw
cm90ZWN0IGEgcmVzb3VyY2UsIG5vciBwcmV2ZW50DQogICAgIGNwdSBvZmZsaW5pbmcgZnJvbSBk
ZWxldGluZyBpdHMgY29udGFpbmluZyBzdHJ1Y3R1cmUuDQoNCjIpIFNlZW1zIGxpa2UgdGhlIG92
ZXJhbGwgcHJvYmxlbSBhcHBlYXJzIHRvIGJlIGFwcGxpY2FibGUgdG8gYW55IHBlci1jcHUgZGF0
YQ0KICAgICB0aGF0IGlzIGJlaW5nIHVzZWQgYnkgYSBwcm9jZXNzLCB2aXMtYS12aXMgY3B1IGhv
dHVucGx1Zy4gQ291bGQgaXQgYmUgdGhhdCBhDQogICAgIHNvbHV0aW9uIGluIGNwdSBob3R1bnBs
dWcgY2FuIHNhZmUtZ3VhcmQgbW9yZSBnZW5lcmFsbHk/IFJlYWxseSBub3Qgc3VyZQ0KICAgICBh
Ym91dCB0aGUgc3BlY2lmaWNzIG9mIGFueSBzb2x1dGlvbiwgYnV0IGl0IG9jY3VycmVkIHRvIG1l
IHRoYXQgdGhpcyBtYXkgbm90DQogICAgIGJlIGEgcHJvYmxlbSB1bmlxdWUgdG8genN3YXAuDQoN
ClRoYW5rcywNCkthbmNoYW5hDQoNCj4gIAlyZXR1cm4gY29tcF9yZXQgPT0gMCAmJiBhbGxvY19y
ZXQgPT0gMDsNCj4gIH0NCj4gDQo+IEBAIC05NjAsNyArOTcyLDcgQEAgc3RhdGljIHZvaWQgenN3
YXBfZGVjb21wcmVzcyhzdHJ1Y3QgenN3YXBfZW50cnkNCj4gKmVudHJ5LCBzdHJ1Y3QgZm9saW8g
KmZvbGlvKQ0KPiAgCXN0cnVjdCBjcnlwdG9fYWNvbXBfY3R4ICphY29tcF9jdHg7DQo+ICAJdTgg
KnNyYzsNCj4gDQo+IC0JYWNvbXBfY3R4ID0gcmF3X2NwdV9wdHIoZW50cnktPnBvb2wtPmFjb21w
X2N0eCk7DQo+ICsJYWNvbXBfY3R4ID0gYWNvbXBfY3R4X2dldF9jcHUoZW50cnktPnBvb2wtPmFj
b21wX2N0eCk7DQo+ICAJbXV0ZXhfbG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+IA0KPiAgCXNy
YyA9IHpwb29sX21hcF9oYW5kbGUoenBvb2wsIGVudHJ5LT5oYW5kbGUsIFpQT09MX01NX1JPKTsN
Cj4gQEAgLTk5MCw2ICsxMDAyLDcgQEAgc3RhdGljIHZvaWQgenN3YXBfZGVjb21wcmVzcyhzdHJ1
Y3QgenN3YXBfZW50cnkNCj4gKmVudHJ5LCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiANCj4gIAlp
ZiAoc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyKQ0KPiAgCQl6cG9vbF91bm1hcF9oYW5kbGUoenBv
b2wsIGVudHJ5LT5oYW5kbGUpOw0KPiArCWFjb21wX2N0eF9wdXRfY3B1KCk7DQo+ICB9DQo+IA0K
PiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAtLQ0KPiAyLjQ3LjEuNjEz
LmdjMjdmNGI3YTlmLWdvb2cNCg0K

