Return-Path: <stable+bounces-206266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42647D04321
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0A834E1948
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF85366546;
	Thu,  8 Jan 2026 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwGbciEy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B73596E8;
	Thu,  8 Jan 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859173; cv=fail; b=JUECUjYUc80sa0mkPJ8rq6vRRupi2MuKk094kEJIzzdagTmDJYN/DyV2IHMBUms7En3STxEZkFVL3M84RUIaxwtBI4LN3bL50EP5Nm+9Gvx+trn19csedkwB9gCo5m+gnPK8fXRxiltfoB40L0XwQAya4jP5xfEv7yKy1UTIobw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859173; c=relaxed/simple;
	bh=b409ge6A98JhTIemov5/vZIqVWk2q1ryOm51eeINSAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wm6QlIzOoNpr+9q6TkaGll9zXGy/kfHMSYwASxMhOQtfnzAYZ/hM/kr4pQ6RuLm8DneGBWT067iW227Ib1oPR1koNuZII64WkI420X3UIJfePnRIw8KK881kfqFojYs2cjW6WGqFCmJL/L2lTsijmEfSDU+s9UpF6qpMo0HhzvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwGbciEy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767859161; x=1799395161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b409ge6A98JhTIemov5/vZIqVWk2q1ryOm51eeINSAI=;
  b=iwGbciEyL5ehB3cBPNjdP7yzqOxv33541GXkZQpAUGQApz6lvWjS2U4i
   Ps81BJ0GK2ZPugBkstKEwPNg0HN1TLriIj9mCldE0Y3Vkt3nK6kbZixmG
   xEjrEECHuf9hEE0F/g/d9dNmqiKh904aU1q7C2VzB+9IrrVs9NFGS4LC5
   sdF/wMJ9f05goAtOsZyzn7m7eennynBSeGmsAPeIxuLD5SmW799yUNa7W
   OrqpDz/Kh3ok5aVeMy1M76BHE/c0E4ENnEz2wI6gIiNwUF+aPA6x2d9RC
   C1wnTg93zU7KLwykohXdbCiVUtlXr2+JU7jjw0MV9co6rV58rXaO+ACHU
   w==;
X-CSE-ConnectionGUID: +ppm8tvXR2iPiNQ0Q6tZAg==
X-CSE-MsgGUID: A2M4F5KmS6SllRZ2eznraw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="71809678"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="71809678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:59:10 -0800
X-CSE-ConnectionGUID: kDUEVgqaRQGJgN8OkZGoOA==
X-CSE-MsgGUID: js6YfzMcRq61cj58jllFYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="207621076"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:59:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:59:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 23:59:10 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJxxK2RDXgSYtYss0jcs2OB9RcWu+Xnb0mjpjFmavh/hz2WNFMk+4Q0m4QtKH5f0D7nNJ0of6AeMOE9kFuzvHsIntVz0BUY04BPMV81BjTC7tDCpTytBxAzWvxBHAg+nmXqDmaTpXKFXDWJIcNpMcakjfBx5NHW6WSvxkyLSglxYNesgjp+89Euc75po3sBMy8v6OtZU3oHsasYzGY48GKALiYmNVm1XhxH0vTtutvRccLQglqUUWnqJZAzz3O+LV2tkMxGsmxU4QihVUP58jMaj6gyYYl8z85JLwub6Gqq3n12FDp2ajipCEOHQOlSy0YN1fnTxTfUrNXRSSMr4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b409ge6A98JhTIemov5/vZIqVWk2q1ryOm51eeINSAI=;
 b=HtfGNb1JBVQZxgO0zk4E4kAtSBkXqUW11XFB0rqjsYqNu+S/mb5ftZg9pdGpCxVFNsmrX0EErU/fGFYODP1tHHs5S3Zsid5lANe1Tk6qjtEHp3odohrTmUQxlMFDzxcURkHP8awQCoCuH2jS6eWWiIDIi1babvUgOmQHpeooBU8lI1NApgoWl0FMSOBQ94Ug8lrhE5Htd2tnx9yVB+UIT9f9RrLfktq29YY3nhzsw3ej435urpQfcSKCIAv/px1hwmg3LGE+TDJx+e0raDTXURElnTsvI/81caW+XcOMbvtVC8B26OJbHU3GAXoI1J90FJGTEOsRI31oEj6ZmCucWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:59:08 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:59:08 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Topic: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Index: AQHcgG56oF4dZ48YGkGw3t9tMdQ0EbVH4y0AgAAARmCAAAQXgIAAADqA
Date: Thu, 8 Jan 2026 07:59:08 +0000
Message-ID: <CY5PR11MB6366F18F00C57AFB8C1E71CDED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
 <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010816-unsolved-wipe-bc45@gregkh>
In-Reply-To: <2026010816-unsolved-wipe-bc45@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA0PR11MB7742:EE_
x-ms-office365-filtering-correlation-id: dcfa55b4-743d-4f3f-e339-08de4e8bcd2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Wmx5Uk1YMlVoUFJLcFpXL2JYdVdvd3lJbGNKY09DQS9hWngzUEZPTVhNajJD?=
 =?utf-8?B?aW9rZkd1Y09YN0hCcXY5VnJ5UEIyaFh4bkc0QjJIU0UzYS9yVDBQL0JqeUhZ?=
 =?utf-8?B?aTl5YWRobExIc2VtN1lxcjFhbzBHUHBxazNvbitLZVZkUEVvS0dhc3VjN0Fh?=
 =?utf-8?B?bXJFRVJkRW12c3V4blFtK3UyZ0xNZDVGdnZvT2Erb1VsMUhXTnp5Q1Fpb3Zv?=
 =?utf-8?B?elpmajRVOExFcUtFZExoTmpoUTd1SStKOFZ4TmJDWS9ZS2hmVEgyNFc1ZWdu?=
 =?utf-8?B?ako4Ky9QM2MzUnBkVUNuUkNKVmJNN0xyL3dNZ2Y3UGl6RFVDY3JRU1Z0Vzlq?=
 =?utf-8?B?d3Q4bHZxN0FGNmhacHNENUd1cnZkejB1WElPcUdpZlBCUHhWS2ZQWHg1SzZM?=
 =?utf-8?B?YTlhWjhTK0Q2N0ZwdWxNNlo1QitEMnRZR1pMMXQ3YW5TYUZyaU5RbUZhdS9R?=
 =?utf-8?B?T0w2MXpRUWlDd211UkY0Q1plNGN3cnhUdHZGUVRTZmx4SVBaSlp4MWIwRTcw?=
 =?utf-8?B?NEpJM2xMeEprcm16ZFpYZ09KdFdvV1NaN0JZaUZXbmt6aUNaT3U4M2NJN3gy?=
 =?utf-8?B?cmUwT3dsdnFoc0RURUZOd3hpcXk1VGZ4SEdtUTRaek82ODZhcnZhVjNQUFFy?=
 =?utf-8?B?MzY1Ny96TGp4dGhwd1VRbHhkTHVkZHpkbU1rdWpzK2RVYW1OM2JFSlQ0cmlZ?=
 =?utf-8?B?Vm5mS3VValZESkRzM25DVHJVVDhVVm9EL21GVk43akI3dkkvZG9XUXZUamMv?=
 =?utf-8?B?UFo2OUl2Rms3VHV3b0hEYmVDZzJzVTBtYlQya0h4Ny9FQkFyRTRKT1U0QnRL?=
 =?utf-8?B?SDhlV1dtLytUUmtmY1pqbTIrSys4ak10QTVtMHB2SEk3REs1ekNBQ3NBdkhk?=
 =?utf-8?B?cUtEYnNka3JibEVtTGhjRDlWS09kTU9SMU9uOC81ajNZK2c3a0lNWHVGQktC?=
 =?utf-8?B?S0lrQVBHTm1nMEJoeDRoVElCTkhVTFFxMHdTSkVPdU5rUUtMNWlrMERJODJR?=
 =?utf-8?B?RVpjWDRHNTF0RTU2a0Q4KzFSTGFSaWVTQ2p2NEJmKytNZmh4MG0zWC90K0lC?=
 =?utf-8?B?QklPUWlYRWp3MGZ0QTZBUFk5MGQyeVBlU1RGRElZTTQrc3YzM1dldS9NM21m?=
 =?utf-8?B?YWxyZEhmMHl4Z3Awb042S01GYUwxbytvdU43Q0ErTW9nc0s0WjZnK3d3OUZ3?=
 =?utf-8?B?VnlmcGttc2ZuZkNzNW5lN0lsdmJ2WEluOHB3THNRYWpSbEgyRXBNcWxJemgx?=
 =?utf-8?B?VXNDZmFQQisvWnlVM05GZ25xUFRVdS9TYmNkUlJqRUJtcHE4am5ZMVZRb1l0?=
 =?utf-8?B?bmlyUjlIQjJiOTJtd3BsNWR0SWVyc0tlbGZKbUo2bHRMNUZsbjZ5NWN5aUs3?=
 =?utf-8?B?SVRCc2sxTURjeFJNV0xvL0pCWXRHQ24xamc4eTVNQ1d0OGltODkyQm0zdHJZ?=
 =?utf-8?B?NGZhMVE0ek8yQ2tKWnp0b1hsSFRCQ2taUVpmSlVhTWJlRjNscEtjQ1RJWnAz?=
 =?utf-8?B?bFRxZnB6TXZWUGJvMFdNdEVNQ1N4SDU3aXV5cjlGbHFFWWN0eW9qd0tJMVpD?=
 =?utf-8?B?MS9PdStNU1dHL2NOdU1ERTRGL1kxTHRRYzJkUStmWXNEZ2tlZ2hOTmttdExG?=
 =?utf-8?B?eHZaa2k5V1Q3UTZ1b2l3eWNEcnpMNUF6SXY3UzBNdC9FUVVMckdEZ09qOVdr?=
 =?utf-8?B?VFZHdWFxWVRZOTlOMGE1L1JqRzIzakVvbWVUTUYxNXpZRk1EOHk2VFZudjVY?=
 =?utf-8?B?YkdDV2d2Mko3T1REUXJaaElnOVRUc2h3T09JTGc2SXlQM3lkajNUSHQrdk5w?=
 =?utf-8?B?bGNZaVlXRjZQd2pJbFJ5UVF2UzlveXdmTkQzWXNTM1hhUVo3TzJseS9JSzFu?=
 =?utf-8?B?dzlhaWlyTXl1MnBjc2F6TjlxRnJJMU94TmNnUXU5UEZKemFrOTgzVDRZT3ox?=
 =?utf-8?B?aFBTWkgrNmZYbDBDQ1VkalpzczVJR1p1VnQrZjFtWUc2L1lHbGMreDV4V09r?=
 =?utf-8?B?YkZVNUVkbjZhSHFpMmVTL3RJRWxmRGFWWnBveVc5RG10MFZHTTlMckpFQ1Bm?=
 =?utf-8?Q?gpi0OC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDgyeUU3a3gwMUtzUE1QYVl0alk0Q3hXcWxBQUVKOFl5Mmt5eUZuZ1hMWlVX?=
 =?utf-8?B?RHh4NWJxV25EQVBPSVcyY3Z3UWRIZzBoV1dJaXYrNE80RzlROGJPaUl5Y0Vy?=
 =?utf-8?B?WERZUmFLdlNHVitMeGcyNDhZREJtL0J6YzI4cmQ0bjlhNGxkdThNNzlMMkVL?=
 =?utf-8?B?a3hkcGFHN3NWa1pPeWpQRy9kR2JDN2V1dThORk0yLzJRY2JkTWNxdzdJNWRO?=
 =?utf-8?B?VmN5M2U2cUFlRzRkRkpwb1l2UzF1S2J1YmttR0lBV2o5djA2b0c3SENPVm1k?=
 =?utf-8?B?WHV5cFVFSGEyaTE0cVpHRmF5SEVZWGFlN0RWbktLVzlqckdWRjdwS3E0SGVv?=
 =?utf-8?B?Z3RWYXZlZ2xqWU8wVHl0SFdZbjhGRTNQWXFRVThIUGpzNFp0c2lQOTRNMGhR?=
 =?utf-8?B?T1VsMS9rb29WUE5JZDE1emNFc3JSckszbTRNUUFtWFU1aE5lSkV5a3o1Wkp6?=
 =?utf-8?B?Q09Cb1JLS1kvUmU0UklLaHJibUpzK1k3SDdrSUdGSHMydGJsS2FiOWxRSmVu?=
 =?utf-8?B?cmJiT29aM0g3SkhYdkdJcU9NbFZER0dIQnJiTlJORnRpeGxjUlBCUlRiTHp2?=
 =?utf-8?B?eHl5REtlRnUyVG5hUWtuSkx0M3hYbW1kSFk0dEJnNFA3NURjRmFDS2Rsd2VG?=
 =?utf-8?B?LzVBTVRYdk12SDFiamFKSDBZZzd6VVRqbmFOdTRoOEZpUVFHWUxxdFZpR0Vn?=
 =?utf-8?B?ejVoc1AydkhaS3NnbWZqWnJ6WWNsRXpkMld3UVJOb1o5Vzl4UFJyQTFZaEJZ?=
 =?utf-8?B?RzZrSXJhWHVvemtubUp3c3cwV0M5T3UzRDdPcm1QZU1idS9hVUxOeWkzWG1n?=
 =?utf-8?B?NlFsQ1U1b2w4SWR3cEVzZFJWOWh2UUFTa09WbExaRzV0TlorWHJqOS9VRVVX?=
 =?utf-8?B?L2I2WHJmNUp0cXQvWGdlY2x4eXhRNnBGQkJ3V05ZemZtbG9KWVZqbEdWZkZO?=
 =?utf-8?B?Y1AvNjJFeW4zbmJyd0pYeU0wMnFkRDNITXV4OHJuTXArTW9qZWJIZ2J4My8z?=
 =?utf-8?B?MjYwK1BSR1ZrV3JsZEV2bkZOeXpDVUpHQ1g5UjNtQzN6NldFVm54UTNYaHhO?=
 =?utf-8?B?VldiMXliN0szMWdBMHVFS0dmVlpyS2g4Tno2ZHlZSDByWmhHMkIranRpYk1y?=
 =?utf-8?B?K25sY1dKZTY1amJ0Rld6ajR6Ynh5NWVScXJTQWUxU3JoUXNhZ1lGcE5LMWtR?=
 =?utf-8?B?V29IemxvTnQyMWdmbTJocXVSNDZTZDNYK29LU1YyR3ZzdVlhQXBJRXhQVDdC?=
 =?utf-8?B?aSs2Z3Z4ellqRG81UFJQNndid0NRYi9PbjQ4Rlc4aWFNRjVVWTZjUWcya1k1?=
 =?utf-8?B?RzF5VDF0NDh0aFpMZ0lURXdGNnpZc3B0OWR1eGgzUDhJbTZ6b2hadFNCaXBT?=
 =?utf-8?B?MnF6T0RBblk5Q1lOTTYyOUprWmE3SXREeFRUTHJPVTdLRVVxS0s2KzMyczVv?=
 =?utf-8?B?ZzAxTlo1ci9uaUo4dXdhRjRWYW5LYyttdnFXQlpmSWlmNG5rV0NKZVkwLzRz?=
 =?utf-8?B?bUtXTW1FMnNGZGs3SGc0VmluVG5CR25xNnloSFROK3hpRDZ6blV0K2NOQVV4?=
 =?utf-8?B?SmJ2OVFZQWN2aW52WU9rMVdvYXJlY2k0SUJ4Y2dad1o3cmhsSmZ0aEZUMG1h?=
 =?utf-8?B?SzBYc2dvMlZIVGdDa21ZVzFPUlVqVlI4MHhvUFBWK29XVzlFeGZRMjZDUkU4?=
 =?utf-8?B?amYvOWdML1FKSXVKTkhxTWtoUWRpTk9ydzJ5OEtzTVJFQnptL05sdkt2UnB3?=
 =?utf-8?B?NTFveXM4TWkzUHo3M3JtQ3hyQzFCcDJ4ZWkyVmZmTUhtRzBhVGNreDNNcVB6?=
 =?utf-8?B?eng1aHRkdVNLbDJQajE5Mk5PRmd5ejBkc1UyOUM0RXdCdFNYNGYxakxTOUZo?=
 =?utf-8?B?alpvSUwyVEtYU1F0QXRQLy9wcVFrTnh4cHllcGNtdk5qSEY0U2srak4vdnRw?=
 =?utf-8?B?Yk96eCtHcFVuMVI4N2llSmVoOEh2NTVwd0hqZHpIWVpVNVdPYzQwR0c2S3pP?=
 =?utf-8?B?dERNTkNISVJTd0dkQmN6Y1hORk1sV0E1NlBKdDBtK2xkY0V6aVhhNlNNQ09o?=
 =?utf-8?B?VGtKNU50QmI0TU53UDdaKzFlK2JiWmxDTk1yUDBBUXBQZ0g5QnRWZDhCWDNJ?=
 =?utf-8?B?SU81K2s5bnJVK0w3RmtDUUh4V053REQ2NUo0NnEvRmpqUmVXK3dneDNXUkNx?=
 =?utf-8?B?U0RTakNIdTl6OWlKdmdDOUtUUUg0ZEhmSytCN1lVdmFYQ1pQMXlsV1AzdHVG?=
 =?utf-8?B?WUFlZnI2cVIyN3BCaTF3cE5VT240VTEwamxFa2s4d2MwZHc4ME0reGIzRWNS?=
 =?utf-8?B?UEdMM3RJQWtTeUtpakJiVUdDVVpFcElsVDlWakdGcU1ESXJvVGlnZXRadTMv?=
 =?utf-8?Q?BEToCi9ci9LpDNFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfa55b4-743d-4f3f-e339-08de4e8bcd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 07:59:08.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aepFYSiqbXFDUl2we5tq/1o/1xKEABUtJ8OSJFRidwdelxXL+Bj9zihx7Jc6WMFl9QFvR24KD2l8Sg5xV8deD/JXLTNwNh6IgSltWOCgDik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYyB2Ml0gbWVpOiB0cmFjZTogdHJlYXQgcmVnIHBhcmFt
ZXRlciBhcyBzdHJpbmcNCj4gDQo+IE9uIFRodSwgSmFuIDA4LCAyMDI2IGF0IDA3OjQyOjIyQU0g
KzAwMDAsIFVzeXNraW4sIEFsZXhhbmRlciB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbY2hh
ci1taXNjIHYyXSBtZWk6IHRyYWNlOiB0cmVhdCByZWcgcGFyYW1ldGVyIGFzIHN0cmluZw0KPiA+
ID4NCj4gPiA+IE9uIFRodSwgSmFuIDA4LCAyMDI2IGF0IDA4OjU3OjAyQU0gKzAyMDAsIEFsZXhh
bmRlciBVc3lza2luIHdyb3RlOg0KPiA+ID4gPiBVc2UgdGhlIHN0cmluZyB3cmFwcGVyIHRvIGNo
ZWNrIHNhbml0eSBvZiB0aGUgcmVnIHBhcmFtZXRlcnMsDQo+ID4gPiA+IHN0b3JlIGl0IHZhbHVl
IGluZGVwZW5kZW50bHkgYW5kIHByZXZlbnQgaW50ZXJuYWwga2VybmVsIGRhdGEgbGVha3MuDQo+
ID4gPiA+IFRyYWNlIHN1YnN5c3RlbSByZWZ1c2VzIHRvIGVtaXQgZXZlbnQgd2l0aCBwbGFpbiBj
aGFyKiwNCj4gPiA+ID4gd2l0aG91dCB0aGUgd3JhcHBlci4NCj4gPiA+ID4NCj4gPiA+ID4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+DQo+ID4gPiBEb2VzIHRoaXMgcmVhbGx5IGZp
eCBhIGJ1Zz8gIElmIG5vdCwgdGhlcmUncyBubyBuZWVkIGZvciBjYzogc3RhYmxlIG9yOg0KPiA+
ID4NCj4gPiA+ID4gRml4ZXM6IGEwYTkyN2QwNmQ3OSAoIm1laTogbWU6IGFkZCBpbyByZWdpc3Rl
ciB0cmFjaW5nIikNCj4gPiA+DQo+ID4gPiBUaGF0IGxpbmUgYXMgd2VsbC4NCj4gPiA+DQo+ID4g
PiB0aGFua3MsDQo+ID4gPg0KPiA+ID4gZ3JlZyBrLWgNCj4gPg0KPiA+IFdpdGhvdXQgdGhpcyBw
YXRjaCB0aGUgZXZlbnRzIGFyZSBub3QgZW1pdHRlZCBhdCBhbGwsIHRoZXkgYXJlIGRyb3BwZWQN
Cj4gPiBieSB0cmFjZSBzZWN1cml0eSBjaGVja2VyLg0KPiANCj4gQWgsIGFnYWluLCB0aGF0IHdh
cyBub3Qgb2J2aW91cyBhdCBhbGwgZnJvbSB0aGUgY2hhbmdlbG9nLiAgUGVyaGFwcw0KPiByZXdv
cmQgaXQgYSBiaXQ/ICBIb3cgaGFzIHRoaXMgZXZlciB3b3JrZWQ/DQo+IA0KDQpUaGlzIHNlY3Vy
aXR5IGhhcmRlbmluZyB3YXMgaW50cm9kdWNlZCB3YXkgYWZ0ZXIgdGhlIGluaXRpYWwgY29tbWl0
DQphbmQgdGhlIGJyZWFrYWdlIHdlbnQgdW5ub3RpY2VkIGZvciBzb21lIHRpbWUsIHVuZm9ydHVu
YXRlbHkuDQogDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCg==

