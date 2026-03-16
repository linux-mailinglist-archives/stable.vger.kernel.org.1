Return-Path: <stable+bounces-225592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MyzGj8juGk8ZgEAu9opvQ
	(envelope-from <stable+bounces-225592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:35:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BF29C7BD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BADC0308FD4F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405D318BA6;
	Mon, 16 Mar 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wnm6sjK2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEF286D60
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674956; cv=fail; b=oZtfCjmyALZRvY7RonjjD1/2Yb6VlMGeRm4G3UhfrPqW13rxEosQTbkZ5WhQkEYCSudhuGocZW3lQSryp85yHd8EqutL9oSCxsSM9Iw4UvRLy/9XQl0i/PurLVPdJX7EnQyGuzHFoadRR+GDNANmKaHjAijCF0dlPJSrcQ+oZLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674956; c=relaxed/simple;
	bh=ndnfbNFCDgzHzEceWBTJkm1sZ5K6lL3+uuUvcD1yk8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZpadMXnL04eG5vYWL5khm8/sF87AvIUJTjaInCB15WLLfR8OvHr5jLy6fBV3Z3Bq82Sc7QQ4ACBf9OAF99731D8Alfv6uPdA4oTz0exyC64cdcdqyrLyV2lzAH8AH9g6sXtk++CfQXn0luw67l8VIkym3pjeQpiAICk5RIwaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wnm6sjK2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773674955; x=1805210955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndnfbNFCDgzHzEceWBTJkm1sZ5K6lL3+uuUvcD1yk8c=;
  b=Wnm6sjK2Mq1qWmUQEEtRAg3wd0FYDhiRZFMEViMRdXYSH72CkMDy9w8v
   uBdlVo20y8N81FqIifEraDMxrRkk+vCtE/1Cj5oa2XiVlhcELakWKaNX1
   WhISVfqD90gjYDpq5lzMD44eggji/Clx7qc4auCDXLTJhnVE++rhNodut
   XuQ2kspgdcu8BsxZCFMQ/VLf9/nc43OaJzCz2zfL7nE++qnfjL7TOm/8C
   C3QtCquJcRN9fZaVj2pm9ZWOhrkbiWyx4MtGnVGd2oCAOGax97sXcAIBP
   ZRnni3Gk30M2jy6SK5UC3Gp5yjS8M2eNMQB20n3ogjGLLW280VDdRogtd
   Q==;
X-CSE-ConnectionGUID: EACjanlhQ6u8aoFEbUlFDA==
X-CSE-MsgGUID: FG3HrQnrSBqOHSTbeIQG3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74580444"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74580444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:29:15 -0700
X-CSE-ConnectionGUID: gDXRQZyjR9+FoJWg4iu6lg==
X-CSE-MsgGUID: KoZIqXWYQI2X3LTAaqXhTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219518036"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:29:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:29:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:29:13 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:29:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJEUkFEaB/SU1j+22cbWerXJwSRYvrDJl+70zQdOZ7If67V+ck+DKwEfihIzfe89x5JDIeZ0tH2TGRetXjQybV4xsAbW0hXrkZkj9DZYdHiiAxMoXutF5RuGDZROcVar1vm9lIG3jN/glsSrxb5GIfWV/fpvT9vvHsZ4yU+Wcxo9tsdxB6D4otl4VvlwGp46PL+nC5r/d6CgIXM6j9OgHl6KThApwiyNK1HakKkbp5Xhs9LbKfakPlXjbv+TW49N2aoObUArpsWu0W4EKJ+nlyKzuBGEYOUjMijsYPlhZfCV6TxYs7nk44nG7LrzG+f9XXFrZeHZB7O4f2MFS7ghlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndnfbNFCDgzHzEceWBTJkm1sZ5K6lL3+uuUvcD1yk8c=;
 b=nOghKVTS+dd7nhXGyiuuxV1i6Mtc+IJeixhuvblc5S2YJ6GWkpk6fCBAcVychDG8LA6oi84F82GPnI065vLmhCYSqc/Z7/CNyTFBe89sXsvSAELj4X1T22Ls6lEG06lqjV7di/pTFUQy9P1sgDSDaHfwF3vrNCPPo0ibwMPACwGe/EqChE8+iqLh9kTp8eZ7m0aEF42jdLVxUwUi9JX9TjnhHVm1KD6aaLySeyGHZSD8Uv4yxF9x2ppeJ5xbBce490L+y2V3aW0G3KJiBbjhsRFrxsBPBIQ+smGWVqUgwLEI2a324G+Dbe93lK0KkhXqGoDkq/IE+pL+MToasl0gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by IA4PR11MB9057.namprd11.prod.outlook.com (2603:10b6:208:55d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 15:29:09 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:29:08 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "Yao, Jia" <jia.yao@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mathew, Alwin"
	<alwin.mathew@intel.com>, "Mrozek, Michal" <michal.mrozek@intel.com>, "Brost,
 Matthew" <matthew.brost@intel.com>, "Souza, Jose" <jose.souza@intel.com>
Subject: RE: [PATCH v5 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU
 cached memory in madvise
Thread-Topic: [PATCH v5 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU
 cached memory in madvise
Thread-Index: AQHctRXKL1xXwr7F5UaeLt0b79fBHbWw/akAgABF4ZA=
Date: Mon, 16 Mar 2026 15:29:08 +0000
Message-ID: <DM4PR11MB545650A51F91E8400FC7E59CEA40A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316072257.255372-1-jia.yao@intel.com>
 <20260316072257.255372-2-jia.yao@intel.com>
 <4b32f17a-811e-453e-ac0a-e5fae77fea6a@intel.com>
In-Reply-To: <4b32f17a-811e-453e-ac0a-e5fae77fea6a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|IA4PR11MB9057:EE_
x-ms-office365-filtering-correlation-id: 50c4f006-46c9-4b69-f38a-08de8370c473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: KjSvUNJO9gHpa8s1tVr0QJ4Thl+QDx4ekeyav+u0WfJjUD9g5ymGnqvuUHYWK2qUlPdjOxfPoYIUxTworUXZ5KaL5rVTgDF6wGTevCsTYD7vnr6jOR3Q/web3gZQCU7hfB1uVyOQovS5Efe7llUgzHzOGL/BBk5zsH4JsqlENOJa6XzrYdESe4S+XKln+JQa/heu6RdsACEqU/PANDAvBRcjDghm+tNnWtSoIjvlS0op2IFKdnQb8MCBqpGUpP/8pONxofjoqy1g49gGaOkj/BzCfIVqcBOhGf/6U7WJuhaO6UvL8/CigMhek0FxjCKJjSKFGz6iEzj9Gv7fCebvCGlc4AfC463Unk2qXIfEXAkC+e2S800FILpfFAit8CqeneINdVKquCDmoM+TvIfJsL7EXHnDIXY8TlWbqnwtNafgXEAifw40FCkz6Fx8xuy7gv3cNocu4maelSM6h9ox4KEmZl8gdMsxXFjAji/2Dk5vzMqv92ah5LqOFsNUpaW5Mjvoe5VC/ounkrIg1qMZD8fjm76IRNxM3/5qssGxpohE87DHWDo6Ssmo9bLQqqb8cj3QjKyBv4gBUzLYSWKLrsWoPg72Hq+2dxA7wn+NCjisuot6VwZ2kI3bRvB1v+2WAnTbUBsecdJYON/VkmEVh4ScSDr+5D/b1LykXBi2O1CbYX/UlpZB2Yh7C80+veR48MATsMQQf3ha3wUEqyNxCpZ37+Siz7BZlXB7/jdOQD5Z/cxueY0ho/L7NL7utoQrLVZpfVYm0Sz3q+GLK29ZG94T8vKHHWAShleUpdK6840=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk44SWJESEV1aUcvK3RhOC94MEoyVVF6THZlMEwvRE5mMkQrOUFsREJSd3lD?=
 =?utf-8?B?THAzemxhSWZ4bTBsSHdXYUhlSi9tSHJXcnBYNDhad0pmT1BrMDV6UnNzUGJG?=
 =?utf-8?B?SWx6UHd3ankwZDJvMkF4TXk1NGsyM1hiYVNWL3Bhb2JZc2NXTC8zc1gwcWtl?=
 =?utf-8?B?LzUvVEYyMEF1L2ZVKzVVTm9TNmZPbkMzZ1FoelAzSWxCa2gwVDNzRUxjRE9Z?=
 =?utf-8?B?bkZsRmRpRHZYZzZ6VWcrYmlGV3JQYjJLOUlYUlorRy8xVEsxeFZFeDM4NTZa?=
 =?utf-8?B?WXE2Mkt2T2Z3WklLZC9CMHowdWo3cmQxSTdCZWtFZkdrNTZiKytRQ2tRc3hU?=
 =?utf-8?B?cS9KYUlaMU9Oa1dZVEl0bU9IcjdxSnNlNHBBaU94MlJydkZnbDU4ZFFjT2o2?=
 =?utf-8?B?ak51SU9lRHJLT0hQZklTUnFHMTlIeVg2UzgzVkRINjRvL2ZtSlJLVmJvbVBJ?=
 =?utf-8?B?VndpdXFxZndBV1dNQzlENnFKbE1tTEJKSnhiWTlLZnEzVmprNHdPOTNNVWxw?=
 =?utf-8?B?Q1h1dU5TdzBFamZpemlEUk1la295aXhGcGM4WWpyWXcvSzhHU0d3Q1FGV3lI?=
 =?utf-8?B?K2JzTFo3NFRXdXh1VmNKMGdJT2ZlSGN4SDM2Tm9GOEl4T1pTTFlpSEpzam5W?=
 =?utf-8?B?ekF6SlRtNzdGM1VIWnFtcG1RUDBCNzNmWnNWWnNOemVjM05icEE3R2UyaGlx?=
 =?utf-8?B?dkQrcThGR1VTTDRhSnA4eWU4RStrV251K0Z4cWV2N0ZqU2UyNmtIMHZJM0Vk?=
 =?utf-8?B?R0ZOSUZaMHhoYi9McjhHbnJZbkoxSTU1Q1g0ak81eUVuSitjNXRiME5HYWdx?=
 =?utf-8?B?MXV3WEthS09BeFFjbWREOUNZS2preTNuWlF3ZWptN2Jqajh2MnVpUElYblp2?=
 =?utf-8?B?K2RMcXI3MTJjYUlBMll4YW0zaXVPVTY5WVcxcktLYVdqZGJNR2JUSERpR1oy?=
 =?utf-8?B?eHJJcFdsY203a0plc09iSTJLRWZSU0FhdGVubjhyRThaU0xSbjl6T043Yk4x?=
 =?utf-8?B?OVZ2akpxWDR2Zy9zOVVpT1BqYndmVEs1V25XYnpQRy9MaEhIODgxUzB4VGxw?=
 =?utf-8?B?SkNCN1A2akxUa1Jaa1RjdS96N2t5N2F0NEpycjRxTDFsa0xieWc4YmNOOVVL?=
 =?utf-8?B?Wkt3WjJFZ1B0RHJxUy9JdmU3OEhhWGhFeVA2YkZPZ0ZCYjQwS2l6dFJKMkZk?=
 =?utf-8?B?L3BndDRDbXNKSitON2lLOW9lQzE4cy9STWFodlJYK1BVZDFGbFkyRCs0a29j?=
 =?utf-8?B?VklnSDZCdWtUSk04V2t2QVpza2dHamFVck0zU096QitUSUtsYmFyQTU1Z2xG?=
 =?utf-8?B?aldiay8xcE9DMmxyRjA2TWcxUGZqVFZZeFRudm9Palo3YUc4NHpCSVVKbGtM?=
 =?utf-8?B?QjBUeFdRKzJaeHUwMDBkdmlaem9vTk9xaEszRW42K09HcHUrRHprQzFpbHl1?=
 =?utf-8?B?bWZOMy9hWUIvSnFmOVFTOGhSeFBGU2NJcDZEa2NCOGdrM090UEtxdHlnbzVD?=
 =?utf-8?B?cktjcTdhbHFPWk5zZ0hIemhIMEFIcDNCdGZVZWR4N2JhMVJTNmNBa0VIbHIz?=
 =?utf-8?B?VVIyQWlhVmFFV2Y4YW5DbkZrWE9FOFRUNmpKK0kyaC95TnNpTWlVeTdLWEVH?=
 =?utf-8?B?WXNWNTNGN1RjWXlmZDFqYzF2YjBhUmZJSXRSbmUxSnFHOEhWYmdmcE5rM0l3?=
 =?utf-8?B?b0p4M1V0S0xFaVdoT3hKYkRYcjdJcytqYkJWS1BwTDRxL2cydVV0Rld2WW9F?=
 =?utf-8?B?WHJvSlM1ZVllYkF5Q0xQNXhlTFpHY3BLeDRSRGRVV1pKQkFueUhWZVlvNW9q?=
 =?utf-8?B?aGsxVnBtNlYyMnByRFpXd0pJSjVoQ09JMEFralBsODdKeTZaa0ZHTmlrR2hu?=
 =?utf-8?B?RS9DL1RBblJhR0VRWDZkSVdaOVpWMTc3NmhOaC8wWUM5SGNoZ0Zmcjh5d0JE?=
 =?utf-8?B?cmlzb2YyMDh3SEZTdE91cUhwU2lQSHI0YWlTMWNHcFBEbjZRSEIvR0djL2VU?=
 =?utf-8?B?VU5OVmJ3OG9yWHZ4T1dUc0d2SnFwUEVPM1hYVWd5dTkvdlF1dWZPY2hBMUls?=
 =?utf-8?B?YmNoL1dkcVUwWjlIV3QvaUVCSFJVeGlDTEYwd201VXNXcXdBRGNpL0hNVnpB?=
 =?utf-8?B?OUNreW9BVXoxUlNmNVE4a0hoY251K09aNUM1WGI2bGJBQzEySlhyeExGZ0k0?=
 =?utf-8?B?ZC9ZbS9IbElCYWl4eWkrVFBrQ00wcTc0dUR5NFE4RGJMcGRacm51UlpyblRh?=
 =?utf-8?B?czlpMUFOLzdKZnRCQzNVRDVJTEtad1pjSlQ2U1dMY2tZaldjVFZiWDJZc0xG?=
 =?utf-8?B?TDZNTlpxbElzcEYvUnoxSi9OMTVlMUNncnhGa1U3VGN5QU1YS2MxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jTYzn2JluxQ/4rYYeteuJLXtUbVC+BX80uIdfdQjlPT/mb/UI/hy3VhmlgW75Oy/b9SeeUHBNPQUvFEkl0H+oczel2IKnTb8aFQmxAn91NgFytTdB0KZzN5bO9xuAVpwJQdDQXzRmAq+EWBs8WonAmIF8ysxOW+OkavLdNLbqy26xPLFATGomhmaO+B60skSLEHOfMna0Ue1QbWtSqbZdFJTWhW3gZSJCy7l6cePoWcUDxl3hJIIFhlV43ZqA9+ZDyUuBhTrsGyyICGDZN2Rg1HGg882f/rpWkxU8E2N49FMCRnvxkJ3nTcAgLM5jvVtlgczvKZFOCUocNkJmjhc3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c4f006-46c9-4b69-f38a-08de8370c473
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:29:08.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpUcxHwCQEx1KUZWtsJhI5YGaXUO8SWIXWjXrwg0R/2apH4jzUuTWtTVWDJoWhvoEPEolzZ1JMO6pA0a+wmTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9057
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0B1BF29C7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCBNYXIgMTYsIDIwMjYgMzo1OSBBTSBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+IE9uIDE2
LzAzLzIwMjYgMDc6MjIsIEppYSBZYW8gd3JvdGU6DQo+ID4gQWRkIHZhbGlkYXRpb24gaW4geGVf
dm1fbWFkdmlzZV9pb2N0bCgpIHRvIHJlamVjdCBQQVQgaW5kaWNlcyB3aXRoDQo+ID4gWEVfQ09I
X05PTkUgY29oZXJlbmN5IG1vZGUgd2hlbiBhcHBsaWVkIHRvIENQVSBjYWNoZWQgbWVtb3J5Lg0K
PiA+DQo+ID4gVXNpbmcgY29oX25vbmUgd2l0aCBDUFUgY2FjaGVkIGJ1ZmZlcnMgaXMgYSBzZWN1
cml0eSBpc3N1ZS4gV2hlbiB0aGUNCj4gPiBrZXJuZWwgY2xlYXJzIHBhZ2VzIGJlZm9yZSByZWFs
bG9jYXRpb24sIHRoZSBjbGVhciBvcGVyYXRpb24gc3RheXMgaW4NCj4gPiBDUFUgY2FjaGUgKGRp
cnR5KS4gR1BVIHdpdGggY29oX25vbmUgY2FuIGJ5cGFzcyBDUFUgY2FjaGVzIGFuZCByZWFkDQo+
ID4gc3RhbGUgc2Vuc2l0aXZlIGRhdGEgZGlyZWN0bHkgZnJvbSBEUkFNLCBwb3RlbnRpYWxseSBs
ZWFraW5nIGRhdGEgZnJvbQ0KPiA+IHByZXZpb3VzbHkgZnJlZWQgcGFnZXMgb2Ygb3RoZXIgcHJv
Y2Vzc2VzLg0KPiA+DQo+ID4gVGhpcyBhbGlnbnMgd2l0aCB0aGUgZXhpc3RpbmcgdmFsaWRhdGlv
biBpbiB2bV9iaW5kIHBhdGgNCj4gPiAoeGVfdm1fYmluZF9pb2N0bF92YWxpZGF0ZV9ibykuDQo+
ID4NCj4gPiB2MihNYXR0aGV3IGJyb3N0KQ0KPiA+IC0gQWRkIGZpeGVzDQo+ID4gLSBNb3ZlIG9u
ZSBkZWJ1ZyBwcmludCB0byBiZXR0ZXIgcGxhY2UNCj4gPg0KPiA+IHYzKE1hdHRoZXcgQXVsZCkN
Cj4gPiAtIFNob3VsZCBiZSBkcm0veGUvdWFwaQ0KPiA+IC0gTW9yZSBDYw0KPiA+DQo+ID4gdjQo
U2h1aWNoZW5nIExpbikNCj4gPiAtIEZpeCBrbWVtIGxlYWsgaXNzdWVzIGJ5IHRoZSB3YXkNCg0K
SXQgaXMgYmV0dGVyIHRvIGZpeCBpc3N1ZSB3aXRoIGRpZmZlcmVudCBwYXRjaCwgYXMgdGhleSBz
aG91bGQgaGF2ZSBkaWZmZXJlbnQgRml4ZXMgdGFnLg0KDQo+ID4NCj4gPiB2NQ0KPiA+IC0gUmVt
b3ZlIGttZW0gbGVhayBiZWNhdXNlIGl0IGhhcyBiZWVuIG1lcmdlZCBieSBvdGhlciBwYXRjaA0K
DQpzL290aGVyL2Fub3RoZXINCg0KPiA+DQo+ID4gRml4ZXM6IGFkYTc0ODZjNTY2OCAoImRybS94
ZTogSW1wbGVtZW50IG1hZHZpc2UgaW9jdGwgZm9yIHhlIikNCj4gPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyAjIHY2LjE4DQo+ID4gQ2M6IFNodWljaGVuZyBMaW4gPHNodWljaGVuZy5saW5A
aW50ZWwuY29tPg0KPiA+IENjOiBNYXRoZXcgQWx3aW4gPGFsd2luLm1hdGhld0BpbnRlbC5jb20+
DQo+ID4gQ2M6IE1pY2hhbCBNcm96ZWsgPG1pY2hhbC5tcm96ZWtAaW50ZWwuY29tPg0KPiA+IENj
OiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4NCj4gPiBDYzogTWF0dGhl
dyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBZ
YW8gPGppYS55YW9AaW50ZWwuY29tPg0KPiA+IEFja2VkLWJ5OiBNaWNoYWwgTXJvemVrIDxtaWNo
YWwubXJvemVrQGludGVsLmNvbT4NCj4gPiBBY2tlZC1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6
YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
eGUveGVfdm1fbWFkdmlzZS5jIHwgNDYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bV9tYWR2aXNlLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bV9tYWR2aXNlLmMNCj4gPiBpbmRleCA4Njlk
YjMwNGQ5NmQuLjVkMGFjYWFkOTI0YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
eGUveGVfdm1fbWFkdmlzZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtX21h
ZHZpc2UuYw0KPiA+IEBAIC0zNjUsNiArMzY1LDQzIEBAIHN0YXRpYyB2b2lkIHhlX21hZHZpc2Vf
ZGV0YWlsc19maW5pKHN0cnVjdA0KPiB4ZV9tYWR2aXNlX2RldGFpbHMgKmRldGFpbHMpDQo+ID4g
ICAJZHJtX3BhZ2VtYXBfcHV0KGRldGFpbHMtPmRwYWdlbWFwKTsNCj4gPiAgIH0NCj4gPg0KPiA+
ICtzdGF0aWMgYm9vbCBjaGVja19wYXRfYXJnc19hcmVfc2FuZShzdHJ1Y3QgeGVfZGV2aWNlICp4
ZSwNCj4gPiArCQkJCSAgICBzdHJ1Y3QgeGVfdm1hc19pbl9tYWR2aXNlX3JhbmdlDQo+ICptYWR2
aXNlX3JhbmdlLA0KPiA+ICsJCQkJICAgIHUxNiBwYXRfaW5kZXgpDQo+ID4gK3sNCj4gPiArCXUx
NiBjb2hfbW9kZSA9IHhlX3BhdF9pbmRleF9nZXRfY29oX21vZGUoeGUsIHBhdF9pbmRleCk7DQo+
ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogVXNpbmcgY29oX25vbmUgd2l0
aCBDUFUgY2FjaGVkIGJ1ZmZlcnMgaXMgbm90IGFsbG93ZWQuDQo+ID4gKwkgKiBPdGhlcndpc2Ug
Q1BVIHBhZ2UgY2xlYXJpbmcgY2FuIGJlIGJ5cGFzc2VkLCB3aGljaCBpcyBhDQo+ID4gKwkgKiBz
ZWN1cml0eSBpc3N1ZS4gR1BVIGNhbiBkaXJlY3RseSBhY2Nlc3Mgc3lzdGVtIG1lbW9yeSBhbmQN
Cj4gPiArCSAqIGJ5cGFzcyBDUFUgY2FjaGVzLCBwb3RlbnRpYWxseSByZWFkaW5nIHN0YWxlIHNl
bnNpdGl2ZSBkYXRhDQo+ID4gKwkgKiBmcm9tIHByZXZpb3VzbHkgZnJlZWQgcGFnZXMuDQo+ID4g
KwkgKi8NCj4gPiArCWlmIChjb2hfbW9kZSAhPSBYRV9DT0hfTk9ORSkNCj4gPiArCQlyZXR1cm4g
dHJ1ZTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbWFkdmlzZV9yYW5nZS0+bnVtX3Zt
YXM7IGkrKykgew0KPiA+ICsJCXN0cnVjdCB4ZV92bWEgKnZtYSA9IG1hZHZpc2VfcmFuZ2UtPnZt
YXNbaV07DQo+ID4gKwkJc3RydWN0IHhlX2JvICpibyA9IHhlX3ZtYV9ibyh2bWEpOw0KPiA+ICsN
Cj4gPiArCQlpZiAoYm8pIHsNCj4gPiArCQkJLyogQk8gd2l0aCBXQiBjYWNoaW5nICsgQ09IX05P
TkUgaXMgbm90IGFsbG93ZWQgKi8NCj4gPiArCQkJaWYgKFhFX0lPQ1RMX0RCRyh4ZSwgYm8tPmNw
dV9jYWNoaW5nID09DQo+IERSTV9YRV9HRU1fQ1BVX0NBQ0hJTkdfV0IpKQ0KPiA+ICsJCQkJcmV0
dXJuIGZhbHNlOw0KPiA+ICsJCQkvKiBJbXBvcnRlZCBkbWEtYnVmIHdpdGhvdXQgY2FjaGluZyBp
bmZvLCBhc3N1bWUNCj4gY2FjaGVkICovDQo+ID4gKwkJCWlmIChYRV9JT0NUTF9EQkcoeGUsICFi
by0+Y3B1X2NhY2hpbmcpKQ0KPiA+ICsJCQkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJCX0gZWxzZSBp
ZiAoWEVfSU9DVExfREJHKHhlLCB4ZV92bWFfaXNfY3B1X2FkZHJfbWlycm9yKHZtYSkNCj4gfHwN
Cj4gPiArCQkJCQkgICAgeGVfdm1hX2lzX3VzZXJwdHIodm1hKSkpDQo+ID4gKwkJCS8qIFN5c3Rl
bSBtZW1vcnkgKHVzZXJwdHIvU1ZNKSBpcyBhbHdheXMgQ1BVDQo+IGNhY2hlZCAqLw0KPiA+ICsJ
CQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHRydWU7DQo+ID4g
K30NCj4gPiArDQo+ID4gICBzdGF0aWMgYm9vbCBjaGVja19ib19hcmdzX2FyZV9zYW5lKHN0cnVj
dCB4ZV92bSAqdm0sIHN0cnVjdCB4ZV92bWENCj4gKip2bWFzLA0KPiA+ICAgCQkJCSAgIGludCBu
dW1fdm1hcywgdTMyIGF0b21pY192YWwpDQo+ID4gICB7DQo+ID4gQEAgLTQ1NSw2ICs0OTIsMTQg
QEAgaW50IHhlX3ZtX21hZHZpc2VfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gdm9p
ZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWwNCj4gPiAgIAlpZiAoZXJyIHx8ICFtYWR2aXNl
X3JhbmdlLm51bV92bWFzKQ0KPiA+ICAgCQlnb3RvIG1hZHZfZmluaTsNCj4gPg0KPiA+ICsJaWYg
KGFyZ3MtPnR5cGUgPT0gRFJNX1hFX01FTV9SQU5HRV9BVFRSX1BBVCkgew0KPiA+ICsJCWlmICgh
Y2hlY2tfcGF0X2FyZ3NfYXJlX3NhbmUoeGUsICZtYWR2aXNlX3JhbmdlLA0KPiA+ICsJCQkJCSAg
ICAgYXJncy0+cGF0X2luZGV4LnZhbCkpIHsNCj4gPiArCQkJZXJyID0gLUVJTlZBTDsNCj4gPiAr
CQkJZ290byBmcmVlX3ZtYXM7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAlpZiAo
bWFkdmlzZV9yYW5nZS5oYXNfYm9fdm1hcykgew0KPiA+ICAgCQlpZiAoYXJncy0+dHlwZSA9PSBE
Uk1fWEVfTUVNX1JBTkdFX0FUVFJfQVRPTUlDKSB7DQo+ID4gICAJCQlpZiAoIWNoZWNrX2JvX2Fy
Z3NfYXJlX3NhbmUodm0sDQo+IG1hZHZpc2VfcmFuZ2Uudm1hcywgQEAgLTUwMCw3DQo+ID4gKzU0
NSw2IEBAIGludCB4ZV92bV9tYWR2aXNlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZv
aWQgKmRhdGEsDQo+IHN0cnVjdCBkcm1fZmlsZSAqZmlsDQo+ID4gICAJCWRybV9leGVjX2Zpbmko
JmV4ZWMpOw0KPiA+ICAgZnJlZV92bWFzOg0KPiA+ICAgCWtmcmVlKG1hZHZpc2VfcmFuZ2Uudm1h
cyk7DQo+ID4gLQltYWR2aXNlX3JhbmdlLnZtYXMgPSBOVUxMOw0KPiANCj4gRG8gd2UgcmVhbGx5
IG5lZWQgdGhpcyBjaGFuZ2U/DQoNCkkgdGhpbmsgaXQgaXMgc3VnZ2VzdGVkIGJ5IG1lLiBTaW5j
ZSB0aGVyZSBpcyBGaXhlcyB0YWcgZm9yIHRoaXMgcGF0Y2gsIHRvIGF2b2lkIGJhY2twb3J0IGNv
bmZsaWN0IGFuZCByZXN0cmljdCBjaGFuZ2UgT05MWSB0byB0aGUgZml4LCBJIHByZWZlciB3ZSBk
b24ndCBkbyB0aGlzIGNoYW5nZSBhbHNvLg0KDQpTaHVpY2hlbmcNCg0KPiANCj4gT3RoZXJ3aXNl
LA0KPiBSZXZpZXdlZC1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0K
PiANCj4gPiAgIG1hZHZfZmluaToNCj4gPiAgIAl4ZV9tYWR2aXNlX2RldGFpbHNfZmluaSgmZGV0
YWlscyk7DQo+ID4gICB1bmxvY2tfdm06DQoNCg==

