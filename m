Return-Path: <stable+bounces-161507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A590AFF724
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 04:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F6561FDB
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149E28031C;
	Thu, 10 Jul 2025 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyjST4Rb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A5280303;
	Thu, 10 Jul 2025 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116143; cv=fail; b=nxbyonVyRNOY1TCqWKEWBZzRFz6psIt6DPklwzv5sfqgLQmdT+j9auj9D783UTwyxt4VlAs8er3mpia44Gby7XPzPsnCXdhfB7PMRPxq7i996M3v0J81dnn39C5hG0Dx8N234CoPXy37roXhENtT2QAx1fTEJxa508z2DUwr5Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116143; c=relaxed/simple;
	bh=yNaukxDUtIKh+6i4MxYCBFTL//c3txWwK3IV5PpSKf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMh7fZZvow4JftbXFL5q6JWLMW6yjybxoKRhD4GU3qZ4VqcWo4nOWUNL6JwG7gWMCnbwRYEyXsyj7orl6th2k92rzmBUbOdNxV92uhPFOeIv0TePTGZjRwm2lBDVzdig5CD/xhjlzoaQRzTBpw5Lhg6UnzYoqyzfQBfCqwnCXUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyjST4Rb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752116142; x=1783652142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNaukxDUtIKh+6i4MxYCBFTL//c3txWwK3IV5PpSKf0=;
  b=IyjST4RbQRtuZ3LgYOh3k7UhyrsW1jRLK4OtoyZCsyeXhIrdkZB3cMRz
   O7IjkGm0/xrPCvbg133WSaLSlGFz1ENynkbFnBXlUWeqw6QY05yQnr2TB
   TLeNS+iFh1leTIBsEp8wM410vdxxydsP3xdckFUAOpV5kLiFvOey5LD5j
   SApdh+NWvTDxwH034QUEHueFKH4Kj5BP9yVOCWiO1a5YzIxra8AmovbCD
   sEWpKcWkPolnDzgpx+doBassqPljn05B2McJm9f0Uk3rbBA7+UD/IDnan
   1kaSKx2kETIf56UHNKEJ3k5dw8dCsfm4VDMHuqgZon0z4jLKmJ7MhApUG
   A==;
X-CSE-ConnectionGUID: smOxKAOyRlShW5ogrir6WA==
X-CSE-MsgGUID: u+0KNjGQQKupdpJqji4lvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54516222"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54516222"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:55:40 -0700
X-CSE-ConnectionGUID: zQc3XzqcRPuYUWplbhGs0w==
X-CSE-MsgGUID: vAYvCgWNRSWgvr/IcLlLgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="155375964"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:55:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 19:55:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 19:55:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 19:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw+0AfsXoGJv1f1xiP0wT1xVI/Od9etaq8WP2N2WTBcjWxlREasl8aqFvBB8CUUiHPwrnR5t995+9Sr6aXJeozriMuA9j5ISRK04AvSr8+KIvssfuECggfMnjAalgAC0mVZ2P+hNXVMEEW1Q4sIOlwmFmSx7xIaMo29RhplifGob184kvCz9bwqnIyfz4HEPYM1CnR+LpMw729fOStltH8+XP7WulraqIFaOiOv/a96bhKTYgiGLk32WQsdv7zrRM8kGMyu/Ps9Ce1UTFcVYlFo2bQx0Vp1znHVVMww1ccLhLgtsT0dqNRknNCJJsqQv7bSlAcdvPE378uJD3sVqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNaukxDUtIKh+6i4MxYCBFTL//c3txWwK3IV5PpSKf0=;
 b=mjeKzF1X8jviIEWqc7A8CoJ7+skQqvX+2DZnEySEUvLjfAhv0OUfFzpEqk1jz6gGkUdadfrv3bwzDK5rz01mnzsm70JrNc619qFRxT/PhfVwsgDf+7UMoyF14xb5vBxbsub6AgL7A60bbwS9BWzxLxi1B0ib4AKZsLC2SQk/UsnnFWV2edmT1elmuCGDf4SwzFB0xVssWLvohW9P5XvQNL0BvZybCQ+uNykmkT6QVHKEyVYwJHQxiej8X8jNEywmoMZLY6fVuV3+l4Ff9/mi2fScGnv8DoK9LFa0UapjN/W0VNiaoU3ScgIpIERRGsgDPXCBlr6vwWWWlQqqZep3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 02:55:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 02:55:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, Peter Zijlstra
	<peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai,
 Yi1" <yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQp63CAgAC0NoCAAApdYA==
Date: Thu, 10 Jul 2025 02:55:35 +0000
Message-ID: <BN9PR11MB527627087764E82D508AEDED8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
In-Reply-To: <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: a2630fde-b3d3-4ae8-2f0d-08ddbf5d3e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1ArSG1CVWF3V1gzSGxXS3pEMTZFU24va1Y4KzZLdVlPdnpzc2xsTEN1cVFO?=
 =?utf-8?B?VTAySTkxcm10QnVpTGorOHZKUmRXWFEyWXVHS2ZhQzRZZHE2SmFFMEZIcnd5?=
 =?utf-8?B?THdVN0tiZDdXTlpXVDhHUzJJMmZZYkR6MGFreUFLUmU4ZmpqczZQWXEwY1NM?=
 =?utf-8?B?bmRkRkE5S1Nqc24zelhkSVo3d0pCV0l4MWJUV1c3N2UyS3B6aG9hb2hMaXRw?=
 =?utf-8?B?Q3dQcXJNbzc2MTJ1VTQzZlg5TlhKMVMvMDAzbE9HaDUyUzNlMHBLSFB1TTRX?=
 =?utf-8?B?MHkrRHNVNnQ1U0ZFdEVUdWNndHNjWDNrUFhJcWVRb1hhVFJGdW9OYUNRcE82?=
 =?utf-8?B?ZWxoUUhsZkw3SmxmV2VoYjRuL3UybkhVbEt1OFRFYzJvdFVuakZCZXdiSnEw?=
 =?utf-8?B?ZlZtNWpCaDREQVZiQzg2SGU0c2FDQUhEMVFiSVUvNkQ1RVhnTU90cnVGZDBV?=
 =?utf-8?B?dzN5M0ZPY2ZIbGFYS2pFTmFJMUd6RUtUK1dnQjBpcC9CQ0x1SDd1U2Y1RHZ1?=
 =?utf-8?B?c2o0SDFFbU0xVEQ3aG11ZHpRWk5sdmE3cTVTMDZueGhpVTZuZVRYMGg2d2h5?=
 =?utf-8?B?UHUxNWs2Y3BwejlpNUFqWk8rUElFRUJkZlZEMTRMNVdLWm5EQWFDb0grYjdJ?=
 =?utf-8?B?KzNvQ1RYTmpmTEJHS1k0V0VOeDUrQTA5OVdIV0R3WURBT2VwdmZKMWl6SlY0?=
 =?utf-8?B?QWI0ZG5Kby9hMFhmT3FvWlJGc285VnBuSHM5SE16emtNZkVVNWtGdVNhaGY3?=
 =?utf-8?B?SXdPemsydEJzWU1LeXQ3dFFPQk5xdDhVbVlDZFJ4Ukw1R3JzT2JobGVBcFJy?=
 =?utf-8?B?c2RaQW1CWXEwMDZEMzVBYTRMSEJqWVBkTm1xVVRSTm9rbkFWdTFJbXZMK1Ny?=
 =?utf-8?B?RHRUOGNkdzJXOEpVQ01MZzNQVHZMeENVUTRkcGorRE5yK3dpdzVZQk5EUGR5?=
 =?utf-8?B?VWdDVG1LajdDOTFzQWdZMmloaXhycm1qK1B3T0huUnV1NXg5Vk5LWElPOS9m?=
 =?utf-8?B?ZXhiSDhaMUw1Qi9UL0RJU25RZkxVcmYvVUJ1TEZyRUVDdTNrOGwxL2F6b3Z5?=
 =?utf-8?B?bi9nRCtKMEJIRko5R2szZVpwbHdibXRVeExVVFlwRjZ3QmhaNCsweTFOM2J6?=
 =?utf-8?B?MXRwZHhJODdMekI1Zk5wN1lZSG1WSHdrZzdmOTBxUUN5NFlIaFUzL2crNFB0?=
 =?utf-8?B?WDVOa28rbnRZOEdCYSthYWw0VHN5c0ZOcEFDbmMxWWVGS3owWFdFREwrbEh4?=
 =?utf-8?B?YVpnWVFhMENHY29TTFB4RlI4WTRKdG85MXNsaVliNGt5Mm5FNDQxVE4vaFNm?=
 =?utf-8?B?Q2Jkc25zUGtIcUp2bDljU2llYitPay9KV2lJblBHNWdWVmc4bjUxUEVnM0pP?=
 =?utf-8?B?S0Npd1A1SktCMGY2YmxSZDV5d3NFajNNOThYS1NKVWVSazZxWmtEMFAyb2JM?=
 =?utf-8?B?OTcxeHdQNXcyelp4WEp3UmcwL2R5cnRiN2ZKa1BvVTdGUnJxdGxiVERhdnJB?=
 =?utf-8?B?RXdwWWh6ZFdkWm9wYk1RaDkxQy9GTU5VQ1I5dkhYZy9VRUFubENXRU9GS1Bi?=
 =?utf-8?B?dk95SkdaY2FHSmJiVnRvY3AvNkp4SmoyR3o2R25RdGhyeTBhRHRwNk5KTjQy?=
 =?utf-8?B?Y0l4dnJWalB3R3ZET1UwNVdOcWhlL0lPK1RjT05CM2Q4d0c2VUpJSkZZM3h3?=
 =?utf-8?B?eUZjNFpxYmowYWpuT0hZbENvN1ZlMFp2WC9yeHJMWDJSdWdvVy9VaUZZaVBk?=
 =?utf-8?B?R3h1ZHFkMzBmUWpCejZmUHZqN2xudUg5NC9YcEFMV2VUNnV3QncvcTRSTXQ4?=
 =?utf-8?B?ZWozWW9IaW40VE1KbEZIa0paWEVLRTFYZkR2NWFCY0docHp4ek9Fd25OQnZY?=
 =?utf-8?B?K2Yxd1U5UUNYbnc1N0NERzV1Z0NVR3hTUHlsZThzV0tEckp5MEhENXplcFBs?=
 =?utf-8?B?c3hsampUaDZyT2FiUlVzeEpoR1RFdlFXRHQyZlVDVEU5dVphTUVtc2Vsa1Mz?=
 =?utf-8?Q?B1lrBqYkbG2D6WBPV2IxM/a9Vk8/4s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRXZTFLV0xEK3dmVFBiRm1Rb2pJSzVoN1B5cXVUenNKc3lFbm5vU0VGMnBP?=
 =?utf-8?B?cG1TdklvODFaazVBS0hZRUVNZVFRSzIrZG9sR1IwcUNsOWFQc25aODhwaHdh?=
 =?utf-8?B?MVBtN0U4T21jNHd1dWN4Y21qR0ZRaStxcmtyN29Cb3FQT2hqQ3lzWEMzSXZ4?=
 =?utf-8?B?L0hxeER0S3g1TXNYRGJwb21LUU1lY00yQll0RllpMEdCNmdsY08ySmNMMk9l?=
 =?utf-8?B?MDlRMTNjd0U5UXBZTUFCY1hNVTRDYzQza0lhTXRTT1JkTkdOZ1dyUDh3V20x?=
 =?utf-8?B?bnRHQ3dvZkdLTndOZWNIemlneWFZeDM5OVRpQkhNNHBPYVBYSDF3Tmcxcmhq?=
 =?utf-8?B?N0JISHpBeXgra3lkTDhGZkZFZlJsek9TRDdrbnZIajhxajZGQk5ZZW5DYklL?=
 =?utf-8?B?OXVFVytpMjllK1dXWnBDZlpHV25XSEFwaDZmaTVqeVJrK0w4bTJGVTBQa3lN?=
 =?utf-8?B?TjB6VXYralVMT2hRVHNBNDRRSzRiampxVTVLM2owOThXekxqblZIeWkvanNR?=
 =?utf-8?B?SExpVjkrbElud0N2R2VzaDMrai8rT2lVZ3dYS21NODlQOHFwZjVwckh4dmZV?=
 =?utf-8?B?MjFWdkRPaHAvSUZOek4vVVRjUDA4eWVZQThWSHk2SXQ3MDJyaU9kbGl3VUlH?=
 =?utf-8?B?SXRxWkFyMEcvTHVjYUZmK0NQV2c2dnZFSFAwTTc1WmY0VjQydjJjWlJvR1Bx?=
 =?utf-8?B?NlZrTXdCYk1iLy9paSt4aC91Sm1mOVJwMG1YU1RXamhZSUhjK01MWkdITVlL?=
 =?utf-8?B?aEdoSm9WM2lwTU54VElTVjRjbURuaFpLL2NnOHFGaFFQRUMxUis4dlBuUXlk?=
 =?utf-8?B?RzBpS09RbzNFSjM0NStoOHY3TnhWQjREWU8yWUZObktCa2RSOXVqMkRodTFl?=
 =?utf-8?B?b1dteEFJWnJqWHJsc1gzeXBqUU80cThkSUZKRTVwaUo2aHdWenVEU1VSK0ov?=
 =?utf-8?B?U2I3WFRyL0RDWFZhbHFtM3JaZVdicVZqQU9aLzcrSWlrQ0gzcU1kV1dqZ2Q2?=
 =?utf-8?B?ZlVFVm5XbGdUNkRJeENEVVNnZjZ2TmM2RGxCeHd6a0RtT1J4djRGMnhicE5O?=
 =?utf-8?B?bXpwdjVYdGdpalhLd0gyVkJpNFhUeUx3RkRUSEFiTjhub2Q4MC9mRXF1b1lM?=
 =?utf-8?B?ZFg5bFluZFUwUHVEZGc0K2pWRnNhZHBwNzJZNURaSUR6aXBZV3JtbCsvVzdm?=
 =?utf-8?B?TUhtb2V1VFpqNFdzMGlGbE1xN0w0cHRRaDRHOHZSdDErcGZPZXM0RHdpUnVh?=
 =?utf-8?B?dC93dy9PbzNWajc2T2VIOU01YVQyS3FNVU5FcmJyUHpsdXdSazJuNy8rbkFS?=
 =?utf-8?B?dEFGUmJpTldCc3BhdWpYYWhFTi9yRFNhNGZtWDNRVTdHRXFWS0RINnB1K29Y?=
 =?utf-8?B?aXVVNUVZNEZlY0tBeGRZVjZ0VytWRVFhakNUT2dVOHAveFZIWklQSSt6T2sx?=
 =?utf-8?B?ZGxlMHRndUJmNWg1RlJzVmhPcXN5aXpIVmw0STZwbjFHR0tkUG9vbWQ0ZHg4?=
 =?utf-8?B?TmJvZ1VaeDZnZnZOUUNwMXBKeUU2ZVQrdmEvOFBKNFpNWWRQMVBpejVmdHBt?=
 =?utf-8?B?VUdiNHM3bVphVHdSOU5rbTJkL2IrRWp5YTRDVEk5RnQrVlJoUTQ3VmFjOGZ6?=
 =?utf-8?B?TlBIbmdnYlIvbmFONU9Cc2w4R3RGU3lPTGx2TFF3Y3g1K1ZQbzB3ZHY2NkNo?=
 =?utf-8?B?T3QvNkVRUDN6V293U1Y1YUdGcUQ0a2tJZTRSa2RhYVFBK05iNVdNTXkwMnY4?=
 =?utf-8?B?NFhxR0NZdS9SMjhFV1R1Q1ZIVXR3c3NSRXJxaUNKb3NKdUx1KzZxOEhYUDRF?=
 =?utf-8?B?NDloc2JJNUVwVjBwU2ZMOVhsTXRnSG1yeWhZVk5OdFpocEZ2ZHU1ZGxEek1l?=
 =?utf-8?B?bjRCdmtPbUJQRzBPTkVhTkw3djc4UEdEeVB6M3ZWNjJhSFNVenRheURtb0Jy?=
 =?utf-8?B?ZFp5UzNUbTJQRTB2eE1qWkJHWThmNEY4b0N6L2N6a21OTWhQMGdGWnNORmsz?=
 =?utf-8?B?N2p3TUVObS9KVnVwN1dJVjgzY1hSNXFONlJtc0tmTzRSaDBlZk1rRGFZMStp?=
 =?utf-8?B?dUFFZUdxL0RKUVh4Ymo3NFRFemJNTjVPaDYya0szdkhOWTRQVWExZC8xb2Jj?=
 =?utf-8?Q?TtLYAotZVYIVeHAe8153M34Xu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2630fde-b3d3-4ae8-2f0d-08ddbf5d3e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 02:55:35.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFriVEhvvlelpUmfIAMc/VBEHzY8atmIzN9+wpcFokNPfjus1NFJVxDbmFVt0TsVwK0aKJ2CspjO2GPCvUPbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVseSAxMCwgMjAyNSAxMDoxNSBBTQ0KPiANCj4gT24gNy85LzI1IDIzOjI5LCBEYXZl
IEhhbnNlbiB3cm90ZToNCj4gPiBPbiA3LzgvMjUgMjM6MjgsIEx1IEJhb2x1IHdyb3RlOg0KPiA+
PiBNb2Rlcm4gSU9NTVVzIG9mdGVuIGNhY2hlIHBhZ2UgdGFibGUgZW50cmllcyB0byBvcHRpbWl6
ZSB3YWxrDQo+IHBlcmZvcm1hbmNlLA0KPiA+PiBldmVuIGZvciBpbnRlcm1lZGlhdGUgcGFnZSB0
YWJsZSBsZXZlbHMuIElmIGtlcm5lbCBwYWdlIHRhYmxlIG1hcHBpbmdzIGFyZQ0KPiA+PiBjaGFu
Z2VkIChlLmcuLCBieSB2ZnJlZSgpKSwgYnV0IHRoZSBJT01NVSdzIGludGVybmFsIGNhY2hlcyBy
ZXRhaW4gc3RhbGUNCj4gPj4gZW50cmllcywgVXNlLUFmdGVyLUZyZWUgKFVBRikgdnVsbmVyYWJp
bGl0eSBjb25kaXRpb24gYXJpc2VzLiBJZiB0aGVzZQ0KPiA+PiBmcmVlZCBwYWdlIHRhYmxlIHBh
Z2VzIGFyZSByZWFsbG9jYXRlZCBmb3IgYSBkaWZmZXJlbnQgcHVycG9zZSwgcG90ZW50aWFsbHkN
Cj4gPj4gYnkgYW4gYXR0YWNrZXIsIHRoZSBJT01NVSBjb3VsZCBtaXNpbnRlcnByZXQgdGhlIG5l
dyBkYXRhIGFzIHZhbGlkIHBhZ2UNCj4gPj4gdGFibGUgZW50cmllcy4gVGhpcyBhbGxvd3MgdGhl
IElPTU1VIHRvIHdhbGsgaW50byBhdHRhY2tlci1jb250cm9sbGVkDQo+ID4+IG1lbW9yeSwgbGVh
ZGluZyB0byBhcmJpdHJhcnkgcGh5c2ljYWwgbWVtb3J5IERNQSBhY2Nlc3Mgb3IgcHJpdmlsZWdl
DQo+ID4+IGVzY2FsYXRpb24uDQo+ID4NCj4gPiBUaGUgYXBwcm9hY2ggaGVyZSBpcyBjZXJ0YWlu
bHkgY29uc2VydmF0aXZlIGFuZCBzaW1wbGUuIEl0J3MgYWxzbyBub3QNCj4gPiBnb2luZyB0byBj
YXVzZSBiaWcgcHJvYmxlbXMgb24gc3lzdGVtcyB3aXRob3V0IGZhbmN5IElPTU1Vcy4NCj4gPg0K
PiA+IEJ1dCBJIGFtIGEgX2JpdF8gd29ycmllZCB0aGF0IGl0J3MgX3Rvb18gY29uc2VydmF0aXZl
LiBUaGUgY2hhbmdlbG9nDQo+ID4gdGFsa3MgYWJvdXQgcGFnZSB0YWJsZSBwYWdlIGZyZWVpbmcs
IGJ1dCB0aGUgYWN0dWFsIGNvZGU6DQo+ID4NCj4gPj4gQEAgLTE1NDAsNiArMTU0MSw3IEBAIHZv
aWQgZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiB1bnNpZ25l
ZCBsb25nIGVuZCkNCj4gPj4gICAJCWtlcm5lbF90bGJfZmx1c2hfcmFuZ2UoaW5mbyk7DQo+ID4+
DQo+ID4+ICAgCXB1dF9mbHVzaF90bGJfaW5mbygpOw0KPiA+PiArCWlvbW11X3N2YV9pbnZhbGlk
YXRlX2t2YV9yYW5nZShzdGFydCwgZW5kKTsNCj4gPj4gICB9DQo+ID4NCj4gPiBpcyBpbiBhIHZl
cnkgZ2VuZXJpYyBUTEIgZmx1c2hpbmcgc3BvdCB0aGF0J3MgdXNlZCBmb3IgYSBsb3QgbW9yZSB0
aGFuDQo+ID4ganVzdCBmcmVlaW5nIHBhZ2UgdGFibGVzLg0KPiA+DQo+ID4gSWYgdGhlIHByb2Js
ZW0gaXMgdHJ1bHkgbGltaXRlZCB0byBmcmVlaW5nIHBhZ2UgdGFibGVzLCBpdCBuZWVkcyB0byBi
ZQ0KPiA+IGNvbW1lbnRlZCBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gWWVhaCwgZ29vZCBjb21tZW50
cy4gSXQgc2hvdWxkIG5vdCBiZSBsaW1pdGVkIHRvIGZyZWVpbmcgcGFnZSB0YWJsZXM7DQo+IGZy
ZWVpbmcgcGFnZSB0YWJsZXMgaXMganVzdCBhIHJlYWwgY2FzZSB0aGF0IHdlIGNhbiBzZWUgaW4g
dGhlIHZtYWxsb2MvDQo+IHZmcmVlIHBhdGhzLiBUaGVvcmV0aWNhbGx5LCB3aGVuZXZlciBhIGtl
cm5lbCBwYWdlIHRhYmxlIHVwZGF0ZSBpcyBkb25lDQo+IGFuZCB0aGUgQ1BVIFRMQiBuZWVkcyB0
byBiZSBmbHVzaGVkLCB0aGUgc2Vjb25kYXJ5IFRMQiAoaS5lLiwgdGhlIGNhY2hlcw0KPiBvbiB0
aGUgSU9NTVUpIHNob3VsZCBiZSBmbHVzaGVkIGFjY29yZGluZ2x5LiBJdCdzIGFzc3VtZWQgdGhh
dCB0aGlzDQo+IGhhcHBlbnMgaW4gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpLg0KPiANCg0KdGhp
cyBjb25zZXJ2YXRpdmUgYXBwcm9hY2ggc291bmRzIHNhZmVyIC0gZXZlbiBpZiB3ZSBvdmVybG9v
a2VkIGFueQ0KdGhyZWF0IGJleW9uZCByZWx5aW5nIG9uIHBhZ2UgdGFibGUgZnJlZSwgZG9pbmcg
aW52YWxpZGF0aW9uIGluIHRoaXMNCmZ1bmN0aW9uIGlzIHN1ZmZpY2llbnQgdG8gbWl0aWdhdGUu
IA0KDQpidXQgYXMgRGF2ZSBzdWdnZXN0ZWQgbGV0J3MgYWRkIGEgY29tbWVudCBpbiBhYm92ZSB0
byBjbGFyaWZ5IHRoZQ0KbW90aXZhdGlvbiBvZiBkb2luZyBzby4gDQo=

