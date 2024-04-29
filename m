Return-Path: <stable+bounces-41734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982C8B5A9B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D41C20311
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF73535;
	Mon, 29 Apr 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USjfx2FS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2936657D4
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398929; cv=fail; b=YFhNaBKHmvSNf1rBHcOUqvir6xxomgNdQ7Fx3aRiPbfwgzsT7c9nQOZU91PYyaXr2B32ql2CAH/+0RipPyFsLGI2h+Bz4Qn0+gqdBHd3OGnuoMMaBCn3ckov5yTZxBj0/hfgobvRHl/Ww0U1vZa+IE9iaHniXm3yZRtKEVdMdmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398929; c=relaxed/simple;
	bh=bzIwM88wSbssGdK9mRMRy1E8CSlfncSYeKgSzOe8ekY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqeedlsrvlX6p/VUpn2PqFt8zIJt8HF4UXJYGs+mFLCmN9cMEQD0oRAlyeKm7fRvWUY8Ij3Ypqj4awbl+OTMdM7yV/PIdoE5oRQykmn4FseR+Wqt3e22r2AVnA3bYQrPJKcXCiaxGDolcvdA1DSkPVl+CTVtP5+8x+9m7nbZKtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USjfx2FS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714398928; x=1745934928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bzIwM88wSbssGdK9mRMRy1E8CSlfncSYeKgSzOe8ekY=;
  b=USjfx2FS3WQUIejqhCaxcqo4SbwUcHjOgKkpMk2Ajk4iAph4i1/lnCuQ
   h3KfUwnFsItu5wn1/eTDphwva6ToKVQmjmwIY6RLdL7bWO/JC8EeG4E+P
   fFDLvjWFm+DEruO5kjWURJSa0LndZQfFAklZ9+xIl1RsMSbtrN8YnOaRk
   1JgzasXk/pRuvljMa4qECzuYEUy/qSN8x50duH94pG0UqDISXvPVax9vO
   z/CllqCCiCmhHbPAJ/+4DCLyOh3cLdq3wA63JFt7Jcb7CyLq3PYeDJEFP
   uaUC9wUFbScXhJoa9BoSfQw7mhf3pmSC4GT2mjQSZ7lx7F4TI+YglkjVq
   A==;
X-CSE-ConnectionGUID: 3mrNVW7wS12LxbKNdkygvQ==
X-CSE-MsgGUID: g/lo5+I4Ro+TYI/AYZlfBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9910690"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9910690"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:55:27 -0700
X-CSE-ConnectionGUID: WW14aU5NSuGYyM3Jwtt3hQ==
X-CSE-MsgGUID: 4EpVbxJ1Tgm6/wu7bwq/cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="25988551"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 06:55:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 06:55:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 06:55:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 06:55:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 06:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0ob+5d2bit1LL4hZPmyQ5RcxqASV26RT8K7GsykUUW2froldm+wLAK5NbEM245HirAHXLgvjbcpEwxYNb+DHLBx/ZNzYBEV+5MTLCVJM+nvRyotMnWdPD5SucEpJA/ftZ3+GRUvvZJNFCfUcOaQlkbOxSDnTh3l7UBOWInGgUx3ai9mqeKA/H+TGRvIvcvdu1JGDvEnzKT0F7HqE94Wblec9+rTN9naXKguqAlSPZja5nTiH3RAFUOSxJrpVR+aeHySBn9e7LkaEhzTeXmO6xpN+Hvn3K1EOh+L5Cy4NbZOktz9feI0aZfBLIMhrGsA8i/PuY4yjLmqy++YG3E4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzIwM88wSbssGdK9mRMRy1E8CSlfncSYeKgSzOe8ekY=;
 b=U6mLRKxdUBPHcpdHNuDImK+FPlatursEg3UV6FxGmq0FnJU+BivKsc/IbocGT+nGdiiKbMzrPRQMcau8mF8RiHCjrxpi+VVcpdYjIuiXlrU9pO9FquwkZaAmPssO8HhbjfCeZYn+iAE2Omwj92jXxeloj5QZH9iug56gM5xFF8/DhAdXIFgCxnTNfuepwhLrzVujxDa4+/iu4RJsQ3c9Y93tw5vfsoJzs7cSUhRtrjNswwR5APFAPnBgsMe9L6xwdR0ZHOD903mWepRz3JKJn8DgO68zqKimulYsTwxIQGO8uWruTPZlydOyOaVS/SHD2w91arfMTt9Xuo6XJzPl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:55:22 +0000
Received: from SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d]) by SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d%5]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 13:55:22 +0000
From: "Zeng, Oak" <oak.zeng@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Topic: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Index: AQHamDIABv9a32EftUGqBpesvr5L7rF/R9wQ
Date: Mon, 29 Apr 2024 13:55:22 +0000
Message-ID: <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
In-Reply-To: <20240426233236.2077378-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6991:EE_|SA3PR11MB7581:EE_
x-ms-office365-filtering-correlation-id: e7b9e92d-a03e-4901-c12b-08dc68540372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UzQwSXpZUlFaTEd4NEVseGN5REIrV01xbmVLNlBZZnRrVTZaalQ3Wk1tdGdM?=
 =?utf-8?B?TkVXQXRsTXZHaVg5QnZYTDNDOUhuRVp2Y2hDZVlHUi9ZcmZUQWJ2UXExcldQ?=
 =?utf-8?B?MUhWQUEzaTlvTDNaVEsvMnVaSVNoVDU2TG9naENzb1hkWnhYYWxBd2VUeFhh?=
 =?utf-8?B?UWxuZnRndE9odGZMUGFYbHdyMWtsWGp0ckRST05nbXZOd2xpOHhEV090Y00y?=
 =?utf-8?B?SkExbjBQV1IzaDloRkRtYVVySi9pNnlkbWxBNE9LUVVJWVI2RFIzWmcrYlFx?=
 =?utf-8?B?ZHkxK2V1VFdZY2tmNnZLTzlIYSszS1BkTWQxNGw1ckdsNWp1Q2JjNmp1Szg3?=
 =?utf-8?B?bnJBYVdVaVVtUWVhNDFodWREMy9wanV1TFZvZThGV1FrQ3FOUmU5QU5XdWlt?=
 =?utf-8?B?a0JCcUM2WlpzeWZPWHN4TE8yTmlIQmtlUmd0dmZzd3djQVY0aXQ5ZCsvR1dF?=
 =?utf-8?B?L2xNV29Qd1dzK0hqYlY3UmxER21VV0dEVEMzVXEwbHFNY0dqVmo1dkd0YVpK?=
 =?utf-8?B?RlRPaU1Gcm9kbzdKZ1BQWnJCenpnaEdRK3BJMkRTVjhZL3pJcHpkbE1KR25Z?=
 =?utf-8?B?TEU0cXh6MTFOODJBWmVjTm44YmVBU2RQRGs1TVZIdUNSajNLOEJOeFhkekE2?=
 =?utf-8?B?cC92aDdzcDl6QUJhNHdkQ3BMRXJoaE95ajVoU1pEdDJyZXQ1QVdTUUtCV2lB?=
 =?utf-8?B?Q0MvOEgxWmgxajI2c29TTU9UWURZMWFhL0J1RC9uUmVjL0YrUWVka1Q5WDE0?=
 =?utf-8?B?Tkg4b2xkQ29qTlVPVUZvN0REd0sxQ2xValJySjVORTlJWHluQm45ZzZ2SHpS?=
 =?utf-8?B?dU5SSXhqRDBmTzEvSmdkNGI5YlF5RldoSEZUaTJBT1c1K2gwUkNxaWlMdStG?=
 =?utf-8?B?Z0ZqZi9YMkNQU3ZlT3V5YzZkcW9VQy9tanlPUnNzUTFCc05NSkdHU1cvakVV?=
 =?utf-8?B?Q1lwdi9yOWdTeEw1MUZ6dHU0QW1vSVdvZTVld3lGL0pGNXBkTkYvS0IweEtY?=
 =?utf-8?B?YjAzdDdCcXhZWHVXd3lKc21XM3BSckFmVGx3djI4UHFjYmovZE00eGVjTWdq?=
 =?utf-8?B?WUNnZ0h2TVoydThLSHZzVWJ6THNUZ21OQWFRa0RRZ1FjWHVFYUZpTGdpYjV2?=
 =?utf-8?B?MUtWT0RsWG9IekZiQzc2Vkw1RlJVNmd3K29vbkZjSHpaQTRIc1d6RmZKNUp1?=
 =?utf-8?B?ckFpdno1eVNFR2R4TStNMVNTTm5nWnhsVXJPajNieE1RRkJJUWZrcURnVlRp?=
 =?utf-8?B?T3M3ZEZxOUh0cERZalM2VzlONzdubnlJR2ZOOGEvY3ZDNVdvYmY5NVlZekFh?=
 =?utf-8?B?c2VSM1ViWnpXbEUrektPeUc5UGZacE56TU9ENUEvU255cXpPZWRBdEZYNkxW?=
 =?utf-8?B?bGVCMFpUN2ltRzBPZnN6UjVDYnFvODR5Mzc0dkthMi91SElGL0FlNTk2Wkdp?=
 =?utf-8?B?YW9LT1p5YWROeTZLWkFISVRMRkw5UkpVMENyUlJVV0FYUEhXcFg0TUhpVkc0?=
 =?utf-8?B?RnBxbHlVdG0vZHU1RjViMjAwYUlGSUI5dTMvYUVRSUcwRjNZNDJKSVF4dUFT?=
 =?utf-8?B?d1lyMzJnRVJ1RGxIanJFQXJtQzhHRnlXT28rZFVacmRENDdzODRkTEF0NVdF?=
 =?utf-8?B?REEwRWZGTGFmd3ZickdFMmxZWWRDbWozbzhXKzlkRzFURExMQVJnL1RMam95?=
 =?utf-8?B?bnZrYXpYUU5XUHdNZW9UdjVxbTNvdTJ3Zmt1OU53NjEvamxROCsvM3RpZzcv?=
 =?utf-8?B?NzlIZ3NQdkw4YzVnMzN4aytnV0xDM2xsdUdRN0tkYnZ4QTFGQ3RCZ1BzTlJW?=
 =?utf-8?B?d2NnKzRSODZPYktObVY5QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6991.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2FyY0ZsMXoxVlJ2dDZ0a2MycEJVRnVMRk1oY1Q0eEM5eDBPUXl1ZTVzSCtm?=
 =?utf-8?B?UHhSN2lKT1V4T2FraWZidHZyN2IvdWJEMXN0SldkMDVHbndNbjFSamNXaU4x?=
 =?utf-8?B?aENaZmhHRWI0SXJmTFduWm9Xa1hCREFOOHRQSTM1MFRrbTMxSjhSM01uT2Rs?=
 =?utf-8?B?NlcySWdLTnM3MU4zWkd3d1cvUFpoNjlWVkwzSnplL003M2ZWVnVWbXZYNk1X?=
 =?utf-8?B?NWw0dVZ3OU1CeUpBOWI2NHFjNjFpZkJndlBaMHBZUFFsRllWQjNuZnRQUk15?=
 =?utf-8?B?blZ0bzB6aGcvSUF5cG1zSWtOZmJCbVRxQmRiZjJqejMyMERsSjU5NGNMZGRS?=
 =?utf-8?B?YmRJbjJrUTVQUGk4OVFSODBJT2M2WHM0Z1VDQ1VtcENqQitPLzcrWm5vUys0?=
 =?utf-8?B?M3lBbHZTdEQzRWMxeTZrRThNTGxHbTNQTXM0K21NeDNEdWNPTVZkdzNGK3hS?=
 =?utf-8?B?d0RXQkhJOERveVQxbHVGNnNxSnhWR2V4M0YreHR0WklYWEZHYzJiMFNGYTht?=
 =?utf-8?B?T25GY2xyYnM5Q0NodnA2STVNclZNUW01WWVoVE5tSFJQTnZNY2gybC9Ta0Nl?=
 =?utf-8?B?c2NTeUVNT0lZeVRKZGEvaDRnbWtsalZlNGFBWTZPS3NWWHd5MjkvSm93Nm50?=
 =?utf-8?B?cVRrRS90OEZIWXZMdVpMUzJ0SXl5OEFkWmR0VmtnZzhkT1NoOG9VRDdxUXlu?=
 =?utf-8?B?bVN5MHQyUkk1T3JpRlhtWEZmbTNhdWpoUjMwRjhic2xwTTZoWjJOZkpDZC9O?=
 =?utf-8?B?YjRHeExrakgzd1VzclhOckwxNEtSazBXQnQ0WUcyWFN1SlllUUpNekhSbTJP?=
 =?utf-8?B?SU9Jd3Z5bDBNa2dDMmI4UzVRWjhRTCtZOUo3TkhqbkJLLzk3c3F5anFnMzVi?=
 =?utf-8?B?ZmI2cHhDWVZpSS9CWk5rZE9TU0s4THNjQlM4MHF0RmFPZW0wcnZwRStON2Vz?=
 =?utf-8?B?Yk5CWWJCckh0Q2RrTEo3SThaaUhENDVxeXJ3dVJ3TWFBa3BzY2M2SDlQbUVi?=
 =?utf-8?B?N3RjTjIvanNHOHBneGx4N1ZGeWlXbHVoalUyNjN3Yi83cGtzcW9NdUQ0YVJ2?=
 =?utf-8?B?WEsxUnBFRkNGd3pJd21WM05GaDZDSGR0WXpQMWMvUVV6QXdiTUQydENaaWll?=
 =?utf-8?B?RVo1WFpuTHMvYzhueXFQcTNWWFRuZldNMnZYY1Y3bmJ3S2FiUjduN2Q0RkU5?=
 =?utf-8?B?dTgwbER6RkhYRjBqRUx1dG9WT1BVLzRJang5VG1WZXgrRFNCRkFvTHVrRFI1?=
 =?utf-8?B?MUxDZjZ3T21YQjl4ZEJsb3BDL3VZc084YyttTFpmSkJBaHE4eE5mL2lkZEdj?=
 =?utf-8?B?TUpFWVFlQU1tLzNqaythdmEwRUp4N0NCVktaS2Fna3g4a0hWQmhsSkJ0SkxX?=
 =?utf-8?B?UTM4UFVMcU40MkJ6UlRQK2hYSTVQbll0a0xlNU9heTkwVjlxS3drVS9RajFu?=
 =?utf-8?B?NmtoMEsrc2FqcEtRQmRyNlVycU53c1NGTEpQaFpqblRJektyTDh6dW5iTml3?=
 =?utf-8?B?dUQ3aGhNK1E5RkJSQVg3Vno4OHc0dytFQkltR1owZDZKQVltT3Ywa1N2ZERo?=
 =?utf-8?B?MDY5ekptSmRhY3Y4U2xnYW1ZWGNNY28rYzZNb3ozYXNRdkJwdTAwc1VFZTJ2?=
 =?utf-8?B?RFVLdjNvOWdXN01SL09QM1R0T1hVUHVVOUVJS3R0OGhHbU4zRUY0NHczYVFy?=
 =?utf-8?B?OTl3ODlhZHB3LyttbDB0b1phRGJOVFU5aWpXZ0ZwQkxCb2NUTHFSUUsvRis4?=
 =?utf-8?B?eVRvL2NQdGVvVzE3OFBlNU5RSEorUkVIQnd4ZDNMbU5rdk4xYWIvK1Q1cUhZ?=
 =?utf-8?B?U2NBRDFHOTJaaE9MTVY2cmIrRENRMExYUFZVbGdZTGFuNFRHUG9NREJCcndw?=
 =?utf-8?B?THFpVDZ2eWtHcjZxVytpUnF2QkdIR1NMRlZRTE5CWldXNitHMHBvMXJ5Zkg1?=
 =?utf-8?B?ZjE5SVNaZ0ZUTWVnNEs4cmpzTktXcUFUVkJFTXFTQ0JMeFpkZjNLRlJkUTVC?=
 =?utf-8?B?b3EvOWFkdzQ0ckl6V085bEJlWVBEaFdsL2Z6bHpDdkFVUjNlN2VFVVdoZ09Y?=
 =?utf-8?B?QjBObkVObGFSRTVmbGxJRTcrQml0a2dqVVl5d0ZDMkdUeFNSVmNNLzRrb0pB?=
 =?utf-8?Q?/fSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6991.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b9e92d-a03e-4901-c12b-08dc68540372
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:55:22.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pY+Gqo2oKQCG7wrOe4I8fMDVImr6haa+gMjEUEkSQZiiaKXXdiMF3aSvSCbliChWSub7HhI/OBjM0WBHaMcgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

SGkgTWF0dA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEludGVsLXhl
IDxpbnRlbC14ZS1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+
IE1hdHRoZXcgQnJvc3QNCj4gU2VudDogRnJpZGF5LCBBcHJpbCAyNiwgMjAyNCA3OjMzIFBNDQo+
IFRvOiBpbnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEJyb3N0LCBNYXR0aGV3
IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT47IFRob21hcyBIZWxsc3Ryw7ZtDQo+IDx0aG9tYXMu
aGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIXSBkcm0veGU6IFVubWFwIHVzZXJwdHIgaW4gTU1VIGludmFsaWRhdGlvbiBu
b3RpZmllcg0KPiANCj4gVG8gYmUgc2VjdXJlLCB3aGVuIGEgdXNlcnB0ciBpcyBpbnZhbGlkYXRl
ZCB0aGUgcGFnZXMgc2hvdWxkIGJlIGRtYQ0KPiB1bm1hcHBlZCBlbnN1cmluZyB0aGUgZGV2aWNl
IGNhbiBubyBsb25nZXIgdG91Y2ggdGhlIGludmFsaWRhdGVkIHBhZ2VzLg0KPiANCj4gRml4ZXM6
IGRkMDhlYmY2YzM1MiAoImRybS94ZTogSW50cm9kdWNlIGEgbmV3IERSTSBkcml2ZXIgZm9yIElu
dGVsIEdQVXMiKQ0KPiBGaXhlczogMTJmNGI1OGEzN2Y0ICgiZHJtL3hlOiBVc2UgaG1tX3Jhbmdl
X2ZhdWx0IHRvIHBvcHVsYXRlIHVzZXINCj4gcGFnZXMiKQ0KPiBDYzogVGhvbWFzIEhlbGxzdHLD
tm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyAjIDYuOA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3
LmJyb3N0QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfdm0uYyB8
IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVf
dm0uYw0KPiBpbmRleCBkZmQzMWIzNDYwMjEuLjk2NGE1YjRkNDdkOCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtLmMNCj4gQEAgLTYzNyw2ICs2MzcsOSBAQCBzdGF0aWMgYm9vbCB2bWFfdXNlcnB0cl9pbnZh
bGlkYXRlKHN0cnVjdA0KPiBtbXVfaW50ZXJ2YWxfbm90aWZpZXIgKm1uaSwNCj4gIAkJWEVfV0FS
Tl9PTihlcnIpOw0KPiAgCX0NCj4gDQo+ICsJaWYgKHVzZXJwdHItPnNnKQ0KPiArCQl4ZV9obW1f
dXNlcnB0cl9mcmVlX3NnKHV2bWEpOw0KDQpKdXN0IHNvbWUgdGhvdWdodHMgaGVyZS4gSSB0aGlu
ayB3aGVuIHdlIGludHJvZHVjZSBzeXN0ZW0gYWxsb2NhdG9yLCBhYm92ZSBzaG91bGQgYmUgbWFk
ZSBjb25kaXRpb25hbC4gV2Ugc2hvdWxkIGRtYSB1bm1hcCB1c2VycHRyIG9ubHkgZm9yIG5vcm1h
bCB1c2VycHRyIGJ1dCBub3QgZm9yIHVzZXJwdHIgY3JlYXRlZCBmb3Igc3lzdGVtIGFsbG9jYXRv
ciAoZmF1bHQgdXNycHRyIGluIHRoZSBzeXN0ZW0gYWxsb2NhdG9yIHNlcmllcykuIEJlY2F1c2Ug
Zm9yIHN5c3RlbSBhbGxvY2F0b3IgdGhlIGRtYS11bm1hcHBpbmcgd291bGQgYmUgcGFydCBvZiB0
aGUgZ2FyYmFnZSBjb2xsZWN0b3IgYW5kIHZtYSBkZXN0cm95IHByb2Nlc3MuIFJpZ2h0Pw0KDQpP
YWsgDQoNCj4gKw0KPiAgCXRyYWNlX3hlX3ZtYV91c2VycHRyX2ludmFsaWRhdGVfY29tcGxldGUo
dm1hKTsNCj4gDQo+ICAJcmV0dXJuIHRydWU7DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

