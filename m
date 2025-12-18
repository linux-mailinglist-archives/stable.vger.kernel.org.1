Return-Path: <stable+bounces-202941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46905CCAC4C
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 09:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9428E3010281
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717232E8B94;
	Thu, 18 Dec 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RckTWQoy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABC2E92A2;
	Thu, 18 Dec 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045078; cv=fail; b=gNtKYURQuBJJmc4ENzY5idLrXMQECxswTVywcltNrHrjAgaEjGFVPa9tRBlHRPh3XVf8GQZVrBCqcABYOEJX2NeavEevNg/rqM0//lVJvkJETuc0soLODY0/oTBHMZOXT5qKjGZow601+RPHNh+9yJNkeP3aBSsG117PUlydP4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045078; c=relaxed/simple;
	bh=6fXHeMytgF7UlORsJd9ajN9u+PkOCxK7Hx+F5ZIR1Ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1CCIryZJGD0/10wCv3FEPohS08lRdnCMbt4MISdkrk506xRtQUOuMd4Q2OZ53VrwGWZTJJ77zlR2BQlMEJ55GtsTh0+yySEpow24n/aU8w1cNm4+Htx+4Gm1TKobVM1sXX/JAFCFqp7z80JyCCCFoTxhtjIxlqh0UQ/ZENpG/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RckTWQoy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766045076; x=1797581076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6fXHeMytgF7UlORsJd9ajN9u+PkOCxK7Hx+F5ZIR1Ik=;
  b=RckTWQoy3LdPdw2DMKg65Z03HpM6LXRKx1nLHjNhnvuhMAmm0JSjav4h
   czAREevCVBspzWHk/mGtBliHYUx0Ivln9p+yWq1e0/uNYOmE0VkKn152f
   PXJXSFPbPAgNJMnB5q7kdYc8T3ff8wscPOGyRs1TrvdA1zIpXuCIDANNN
   Y8txxRH3xBc6+Rs8ccDdmfoAPURs15KDlXCHuXPzy0dJPFaESdFhq0DQk
   BS4hN4mOSfj8PkZsLgmpV1nByVcoDXqNk+ZrT+0Qoa8nml1NzSSfyhjRX
   yUlsrlRO4yjp6lAv0vEQqEKQSsBibnovbTz/ztsdimBv7/QFykgg1Rq5b
   A==;
X-CSE-ConnectionGUID: pzTNFjZbQuOxPK2LRzOuwA==
X-CSE-MsgGUID: tvb7MUwBQVGGFJMSlRWZTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="55568778"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="55568778"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 00:04:35 -0800
X-CSE-ConnectionGUID: F3gpKsp9RZSwJ9p75Q8KPA==
X-CSE-MsgGUID: 6nrgzmL0T26JoAyKivL6Kw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 00:04:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 00:04:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 00:04:34 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 00:04:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6bkdA0tGjCIprT/Hoa2QLvRsyzjh7EU1DWjwauxDXbL2HB73xZhGwyKFF38tANSq+NNFj/QjUK0s2ozwBl5/4UOR44zsH4UMQswWdqYjbnB86l5jIhndtmtFl33j9TkdnRN72dCCNjpQD18A21uAutE8OLjVOqmcDlGRc4vzifi5dpjMog0/TYoBFSPesAXSDin0QjlnYnp0oauzC4uHImzMvcJ8Z2tdxXHX+xVYTJ2q5O1P2RcZrfRH5MRPKXaTZxe/4gRhfodw9tc3zASLjT46+QRq9fycPNrRbsVOqOJjnMJB13DB4TSPfhtsRfIDnuscB5TL6xpEJ4grV6mHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fXHeMytgF7UlORsJd9ajN9u+PkOCxK7Hx+F5ZIR1Ik=;
 b=ION7dxPXK91EMmHKs6WYrTusGBvN40Bs7UGvaPljlrp/U6IdLK8DmsF2IlvePiNt3uHOZCJTtQBiM1O5rM2UCIPaNhp8I9qWU+vf7qo2twmr5x+SLr9jvNrz6B/CdDxTcUaJ5cVluM3Qn/TZrUOobYGsCVvMpuVhn+2xW1OvCHQJAbMBHJ3PrfWLz5yGqFaSYnawagLXCGsNPbsgKkLjlgarCggDWQuZn871+ZXZKPiOHWGn/GJ6MkTfKrfuv5QCcvaBYlX5ELv6BPvef7I4JIZmJB2LnV+0sVjC5IzULUZpT1vURG8jzf8jqOwMKIpbZuDfVbUC7v5H03F+6El4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:04:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:04:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Guo, Jinhui" <guojinhui.liam@bytedance.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "Guo, Jinhui" <guojinhui.liam@bytedance.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Index: AQHcalLjYTc62byjOUyaz3iqPujJhLUnDxcQ
Date: Thu, 18 Dec 2025 08:04:20 +0000
Message-ID: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
 <20251211035946.2071-3-guojinhui.liam@bytedance.com>
In-Reply-To: <20251211035946.2071-3-guojinhui.liam@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7084:EE_
x-ms-office365-filtering-correlation-id: afbafd89-b34f-426d-83ae-08de3e0c0c81
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U2M0elRvMjJNZzkxUFVGN0pVY2VSVG1JK2JuSDQ4akoyMG4rTlNoOEpmS0E0?=
 =?utf-8?B?Uk1sNUFjejI4MUZVbzU0dnIyQjhDS0NzQzlrWGdweGhZTG1xdzhxK3JENzgv?=
 =?utf-8?B?d3FhMTN6dWo3N2tCQWVFdzFSOFRJRGJhcFNacEdKcHFTOUhSeTR0L3FMNnJi?=
 =?utf-8?B?RSs3SGxvNXFyQlk3Y09KNnJ6ZEZoelNVd3RKc1dXZGtqaUF6bWJRNDNkU0Rw?=
 =?utf-8?B?YndZTmhzcnZ6V0Rnb1dDKzkxN3dUVllqR3I2a3ExcjZzb1R6b1RDaVVXQUto?=
 =?utf-8?B?NHczVy9jZE5SUTM4clNmY3dlVzlsTTR6V3pyNTQ5c1c2a0c5V1pRVSsraUN4?=
 =?utf-8?B?aENoN1pGd05Jc2pZTmtVckFUSEp0b3doc0UrdmllQk5yd2JzL3ZtQVowNHBq?=
 =?utf-8?B?R2J0OUI5aUtsOHFqRUgwMjFhSDlKMytjQVI5dUltdG9kUklvdzBFbUViTGo4?=
 =?utf-8?B?RG53eGVrb3dqZ2NBL3BnSkw5a0lsUHFYU3dHcGZJNGZTNUVJR2lCRGNFYlhs?=
 =?utf-8?B?bkRkRGQ1WEk2TXBIOFh3M1FXZDhpczBoeXdOYUVOc2xnV1RSdUcvT2ZNOG94?=
 =?utf-8?B?eVBhYzFxdEgzOGw3VXBNNDFqMEpySzB3SmVLb3d6ZE5SMFdzMDd2b1N1UXVn?=
 =?utf-8?B?Uk81RDFkMlVPUWJsYTBxS2VkT2U2VVl0YnVMMnJYeUFpN1RUcnUwaXd4TzIv?=
 =?utf-8?B?dndueTFMcHZPUVA3STE4MVEwbTZWcVRSd3JDR2pKRGZBWnFkYVJwd0xITDRX?=
 =?utf-8?B?cEg1dFRMK0hKNUNrOEp1YkZtQkUxVFBoNFU4T0ZHWmVzZXd4SmQ4TGQwS1VG?=
 =?utf-8?B?RHFxd3JsN1RmanRlRjRmVTJsbXl4U3Y4M2V0d0ptdktVODkrVzBkMXlJMndw?=
 =?utf-8?B?SjMrcGpPbjRSeWMzbUlZR0hVT2NSUE5XNjJMa1dndHdMZDBUaDRPbGMva21S?=
 =?utf-8?B?TXlCdlFOUiswZUlnaHBGREtSVkZodGluWWw4RjNMSElVT1RCNDhKSzVSZmhG?=
 =?utf-8?B?aTZURmhxdmpVOEVVRy9mVkJvcmV5MkIwdE9jMUtla0J4OCtNSjVxVzNKMlhL?=
 =?utf-8?B?YjV1NEdLVGNOUEY2L3ZtcUY4Q3NLQzRtUllHVEdpUERFMUhIdUhoa2J6ejNV?=
 =?utf-8?B?Y0xDa2VjZUI4L001UU1XL0FnSFozTkFNMW85WVJsTjdOT1M5QmdvNWJuZWwx?=
 =?utf-8?B?d09GM2cyUFBCNWliUlBhSndKZUxVUjZ5NUMxQk9NYTluZjY3YStrcllUQmFD?=
 =?utf-8?B?emxwTUVyUWp4SEYySng1U2VNSFJmRENueGZCWWR3TmUycCt1eHhNVXlCNzdx?=
 =?utf-8?B?MXRIcEZacVJRd09PejhBaGk4U2JEWEFXM3VVQXBSRmNmMWpGcXVlMklpT1dI?=
 =?utf-8?B?NmxGWUxxRVpUMjBEVVNNVXh5T1FSRlBpRVdVWDdxNlMzUU9lYUNzS0VZRnMv?=
 =?utf-8?B?TWI2aWdzdlpkT2RMeVBpKzVkY0VWeFRKN2hUbDVBb2laTnk1ZmJzYUFoUzQw?=
 =?utf-8?B?ODJvOWgxeVREbkJzYUI1OXpvckgyekMvaUk2NHJyOEtvMkkvYTRLQ1NobmVr?=
 =?utf-8?B?ZE5oRElKTjF4U2pxSUNpWGtraitXM3FoLzB5QUUwV041eFJxd1FLYk5mVEFn?=
 =?utf-8?B?T004OUlSY1o0UVAydklPWm8rVGxaRnk2QVR2OEptMDRjRmoyT2FlekUxSUE2?=
 =?utf-8?B?Znd2eUJMRGJMS21aSjhxTElGL2xIWkxPM2h5QjFNb0w5cFh1WTA0RnF3OVhP?=
 =?utf-8?B?K3JsZCtEdlEwL2hZc0Z4YWwrbkZ0M3ZsSGdGVnlCUitUMUFEaGtucWJjb0l0?=
 =?utf-8?B?a1ZObjhwS1E3bzg1V2pUaFpGN2ZrZXBjM3lUUkc2aUhrWStrbk5ud3JQcVFZ?=
 =?utf-8?B?cVgvSWQxRzl4SGtIckFmSG90UFZjZ1FhVHFJQ2VzQW5idWRuVXExbTJSVVRB?=
 =?utf-8?B?Zi9VZWJNd3lGRjNXZmZXdEJldUsxbWx0YjU2TDdick5WdkdYemtOaGYzUzJ3?=
 =?utf-8?B?T29XZzZ4b3RNNHRyY3BQZFlML1RrWUtVS1YwV3d2UmQyOE55M0p2N3VrWnIr?=
 =?utf-8?Q?7WoakP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklXVWYxTDBwNXVwV2d3NldiOHREK2pxMGFWSnJJQ3pmaGhuQWIxK01Rc2hL?=
 =?utf-8?B?ajhJR1VMdzNyNkVrT3A2VVhwSG02N2VOYTE1Tk9NNGEzYmRhZkttYlV5Wkxy?=
 =?utf-8?B?NWF6WHhxTnUrZXl5Skc2SUZTQ1hJb0FVWjgxRmdFT2pUUWRMQXFVQlcrM1B6?=
 =?utf-8?B?Q3JiRDdZenYwZHFYYW9QRzlTaXhQTThCSXV3czV4U2FEWkJDcnlXSmVFNU1O?=
 =?utf-8?B?RWNrK2ZDeTJXbWMzeXpmYTlNTTdNVmpFRFgyQVF5YW8zWHNZbytCeEoyK3Yw?=
 =?utf-8?B?cnBmVEZqOGRQaXRncHI5SHY1YytidjRKRFNjRHQ2MVZJVDlBUnVoMFlZVUM3?=
 =?utf-8?B?aVk4WndncVRvYTdvaUFZaTdZN2RqalQzdjllVmhqckhuS05jZVovdGVSaHo2?=
 =?utf-8?B?N2VaUDhHL0hQaHBxT1JOclFZT0tqNGozNkZqRVpHZHQ3NzJnQ3N4VTlHL3E0?=
 =?utf-8?B?Sk5hcy9GTU10NTlFYVdEVWYwaFM4WG9OdUhnUVd6b0psZ1laSk00bVVOT1FB?=
 =?utf-8?B?NjRVbkdwbjV6aVdEZFpPaEJjUmUzMXFtc0lnL2lCMzNyTEdBZTdtcVIwU3JI?=
 =?utf-8?B?cUxwTFFHUk9jWWVGdlpmZnUxZWxyblNZM0lId1ZEc3Rib0FDeSsyd1laVzZU?=
 =?utf-8?B?TUMyYkxSYmlqL3g0S2xJNUprQllYdVRCOU40OHgzVndjYisvbWtWMXdKemo2?=
 =?utf-8?B?citCVncvd3NvU0txVC81Zlp5cGJ6WUlxOXp0RGZmVlBPbzNXNEFrdko2Q0JC?=
 =?utf-8?B?VUE5d3U4ZGlQd2k3ZGpHdXZZNHN5Nit1aVpINWJEYnZ6RFJhUkRMMG5zTFB2?=
 =?utf-8?B?ZWdFajFiMFRWa0VmRS9PTFovNFZ4QkdPd25OYUNBaGI1OGFQL253UGFDQnZx?=
 =?utf-8?B?OHkwSm1SK3NxNDgvVmxiSVJtaGJkZm85aXFUT1Uwa3NhMDgzUVg0TnEvZFBy?=
 =?utf-8?B?S0oyUXRud1NZeEZpOWdRYUp3MFZpbGNYOVE0L3o5aDNNWHVVZjIxL3ppZzBE?=
 =?utf-8?B?VmRJL0c5K3dQQ0hBMEVQdXhsb3hoVHdibEVHeTJ1T0lUbldrMlFCOUUreWZq?=
 =?utf-8?B?RjRjTGZRZW1uNXlmcDdlcnAzNWpWTXc5UWQ4QzJxOXA2N2lKWHJ5c3U3cER3?=
 =?utf-8?B?bHJVVXFRSGNtRUFTcW8rVHdqK21yMGFMeXFJZTRaMis0cTljVCtkMDZ3MTdL?=
 =?utf-8?B?bzM4eXpSeER4QlJ1Y2U5Zk5XNERyQ1hLbFVsTlpualN6ZmdIRk4xdWcxYWNK?=
 =?utf-8?B?Qmk5ZGpxVkQ4MU0xZ1RBd3g2MStRbHJrRXk5UDlwY0xvTGFveENBWlBWZlM3?=
 =?utf-8?B?azZ4MkhtZk83YVdQaHhOMmpFanZFVVZadEl1TTBaNUViRGd5TFFhcjF0OWoz?=
 =?utf-8?B?NkdRa1lsS0lndjBkdWR5bUNsMVpaa1NTUjFhRUVxYlhxRzhySWRPRmcyc01X?=
 =?utf-8?B?ZCtMWmo5cUFzSlVOZStsYTh4WEc5WDltLzBXQ2JvUUFDMTBmd0c4OHFsMHcx?=
 =?utf-8?B?YWExTG9vbDJaODMvSXMvcDNDUms1TWwzQUp1RHV1TEIrZkh1MXN4OVI1aFU3?=
 =?utf-8?B?R0VNYWdnb2laK3ZnN0xjbE4zb1JNWVBMZ2lSMlhsUlFLcnBoVWJ5Z1R1SElW?=
 =?utf-8?B?NWdKemVWN2xqdnhuWmp2aW1KK2IzTDkyRmxRbng5SGlxU05QbnhTbVVSL3pJ?=
 =?utf-8?B?TnlVN0FpNlJFODJBdnRkdm9GVGlxbE1MRWNQblg2YURDZU1rc01HT2d3bGJm?=
 =?utf-8?B?T0RscEsrbTArS2d5YjBWUkxleFYwV0RSQkdDbVhxeGswcnp1YzIwdTI2bzJw?=
 =?utf-8?B?TDBPcncyY2dVNEE3N3FHc3JyUzZ0RC85TnluQi9ocWVqTzFmYy9uRkV4MjJB?=
 =?utf-8?B?UWFuUGJWMjdlRjlqNEdUYnRWUTNYU3NSZmYrTHQrNk1WQzVJZGtidVdXeGRk?=
 =?utf-8?B?M3BUcXJTdnpqcUVXeVdQRnRTK2tOQ3FSZDFmcDErSkN5UFBYM1ZNUEtPV2Ft?=
 =?utf-8?B?Sk9ONS84cWlIMUJLZHNJQWNGTllOY0toSlRhOFQ3K3V6TDRDVlBkR0RiWXJV?=
 =?utf-8?B?TDZKMlpJWkpJczVCOUU4ODd5cmptbHJrek8xcjIydkN4M1NtUE9PSkdSMjR4?=
 =?utf-8?Q?f1W7jaySmGaGmAxU0PvqtDlIn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afbafd89-b34f-426d-83ae-08de3e0c0c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 08:04:20.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCvuUkqD7aq9/jIRRxjZVzd9pDLae16bUPcccqQucM3AqwwTI7aI1rnrYb+r6mQAUoG8qCL8Xx5eIcW0yprnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com

PiBGcm9tOiBKaW5odWkgR3VvIDxndW9qaW5odWkubGlhbUBieXRlZGFuY2UuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMTEsIDIwMjUgMTI6MDAgUE0NCj4gDQo+IENvbW1pdCA0ZmM4
MmNkOTA3YWMgKCJpb21tdS92dC1kOiBEb24ndCBpc3N1ZSBBVFMgSW52YWxpZGF0aW9uDQo+IHJl
cXVlc3Qgd2hlbiBkZXZpY2UgaXMgZGlzY29ubmVjdGVkIikgcmVsaWVzIG9uDQo+IHBjaV9kZXZf
aXNfZGlzY29ubmVjdGVkKCkgdG8gc2tpcCBBVFMgaW52YWxpZGF0aW9uIGZvcg0KPiBzYWZlbHkt
cmVtb3ZlZCBkZXZpY2VzLCBidXQgaXQgZG9lcyBub3QgY292ZXIgbGluay1kb3duIGNhdXNlZA0K
PiBieSBmYXVsdHMsIHdoaWNoIGNhbiBzdGlsbCBoYXJkLWxvY2sgdGhlIHN5c3RlbS4NCg0KQWNj
b3JkaW5nIHRvIHRoZSBjb21taXQgbXNnIGl0IGFjdHVhbGx5IHRyaWVzIHRvIGZpeCB0aGUgaGFy
ZCBsb2NrdXANCndpdGggc3VycHJpc2UgcmVtb3ZhbC4gRm9yIHNhZmUgcmVtb3ZhbCB0aGUgZGV2
aWNlIGlzIG5vdCByZW1vdmVkDQpiZWZvcmUgaW52YWxpZGF0aW9uIGlzIGRvbmU6DQoNCiINCiAg
ICBGb3Igc2FmZSByZW1vdmFsLCBkZXZpY2Ugd291bGRuJ3QgYmUgcmVtb3ZlZCB1bnRpbCB0aGUg
d2hvbGUgc29mdHdhcmUNCiAgICBoYW5kbGluZyBwcm9jZXNzIGlzIGRvbmUsIGl0IHdvdWxkbid0
IHRyaWdnZXIgdGhlIGhhcmQgbG9jayB1cCBpc3N1ZQ0KICAgIGNhdXNlZCBieSB0b28gbG9uZyBB
VFMgSW52YWxpZGF0aW9uIHRpbWVvdXQgd2FpdC4NCiINCg0KQ2FuIHlvdSBoZWxwIGFydGljdWxh
dGUgdGhlIHByb2JsZW0gZXNwZWNpYWxseSBhYm91dCB0aGUgcGFydA0KJ2xpbmstZG93biBjYXVz
ZWQgYnkgZmF1bHRzIj8gV2hhdCBhcmUgdGhvc2UgZmF1bHRzPyBIb3cgYXJlDQp0aGV5IGRpZmZl
cmVudCBmcm9tIHRoZSBzYWlkIHN1cnByaXNlIHJlbW92YWwgaW4gdGhlIGNvbW1pdA0KbXNnIHRv
IG5vdCBzZXQgcGNpX2Rldl9pc19kaXNjb25uZWN0ZWQoKT8NCg0KPiANCj4gRm9yIGV4YW1wbGUs
IGlmIGEgVk0gZmFpbHMgdG8gY29ubmVjdCB0byB0aGUgUENJZSBkZXZpY2UsDQoNCidmYWlsZWQn
IGZvciB3aGF0IHJlYXNvbj8NCg0KPiAidmlyc2ggZGVzdHJveSIgaXMgZXhlY3V0ZWQgdG8gcmVs
ZWFzZSByZXNvdXJjZXMgYW5kIGlzb2xhdGUNCj4gdGhlIGZhdWx0LCBidXQgYSBoYXJkLWxvY2t1
cCBvY2N1cnMgd2hpbGUgcmVsZWFzaW5nIHRoZSBncm91cCBmZC4NCj4gDQo+IENhbGwgVHJhY2U6
DQo+ICBxaV9zdWJtaXRfc3luYw0KPiAgcWlfZmx1c2hfZGV2X2lvdGxiDQo+ICBpbnRlbF9wYXNp
ZF90ZWFyX2Rvd25fZW50cnkNCj4gIGRldmljZV9ibG9ja190cmFuc2xhdGlvbg0KPiAgYmxvY2tp
bmdfZG9tYWluX2F0dGFjaF9kZXYNCj4gIF9faW9tbXVfYXR0YWNoX2RldmljZQ0KPiAgX19pb21t
dV9kZXZpY2Vfc2V0X2RvbWFpbg0KPiAgX19pb21tdV9ncm91cF9zZXRfZG9tYWluX2ludGVybmFs
DQo+ICBpb21tdV9kZXRhY2hfZ3JvdXANCj4gIHZmaW9faW9tbXVfdHlwZTFfZGV0YWNoX2dyb3Vw
DQo+ICB2ZmlvX2dyb3VwX2RldGFjaF9jb250YWluZXINCj4gIHZmaW9fZ3JvdXBfZm9wc19yZWxl
YXNlDQo+ICBfX2ZwdXQNCj4gDQo+IEFsdGhvdWdoIHBjaV9kZXZpY2VfaXNfcHJlc2VudCgpIGlz
IHNsb3dlciB0aGFuDQo+IHBjaV9kZXZfaXNfZGlzY29ubmVjdGVkKCksIGl0IHN0aWxsIHRha2Vz
IG9ubHkgfjcwIMK1cyBvbiBhDQo+IENvbm5lY3RYLTUgKDggR1QvcywgeDIpIGFuZCBiZWNvbWVz
IGV2ZW4gZmFzdGVyIGFzIFBDSWUgc3BlZWQNCj4gYW5kIHdpZHRoIGluY3JlYXNlLg0KPiANCj4g
QmVzaWRlcywgZGV2dGxiX2ludmFsaWRhdGlvbl93aXRoX3Bhc2lkKCkgaXMgY2FsbGVkIG9ubHkg
aW4gdGhlDQo+IHBhdGhzIGJlbG93LCB3aGljaCBhcmUgZmFyIGxlc3MgZnJlcXVlbnQgdGhhbiBt
ZW1vcnkgbWFwL3VubWFwLg0KPiANCj4gMS4gbW0tc3RydWN0IHJlbGVhc2UNCj4gMi4ge2F0dGFj
aCxyZWxlYXNlfV9kZXYNCj4gMy4gc2V0L3JlbW92ZSBQQVNJRA0KPiA0LiBkaXJ0eS10cmFja2lu
ZyBzZXR1cA0KPiANCg0Kc3VycHJpc2UgcmVtb3ZhbCBjYW4gaGFwcGVuIGF0IGFueSB0aW1lLCBl
LmcuIGFmdGVyIHRoZSBjaGVjayBvZg0KcGNpX2RldmljZV9pc19wcmVzZW50KCkuIEluIHRoZSBl
bmQgd2UgbmVlZCB0aGUgbG9naWMgaW4NCnFpX2NoZWNrX2ZhdWx0KCkgdG8gY2hlY2sgdGhlIHBy
ZXNlbmNlIHVwb24gSVRFIHRpbWVvdXQgZXJyb3INCnJlY2VpdmVkIHRvIGJyZWFrIHRoZSBpbmZp
bml0ZSBsb29wLiBTbyBpbiB5b3VyIGNhc2UgZXZlbiB3aXRoDQp0aGF0IGxvZ2ljaSBpbiBwbGFj
ZSB5b3Ugc3RpbGwgb2JzZXJ2ZSBsb2NrdXAgKHByb2JhYmx5IGR1ZSB0bw0KaGFyZHdhcmUgSVRF
IHRpbWVvdXQgaXMgbG9uZ2VyIHRoYW4gdGhlIGxvY2t1cCBkZXRlY3Rpb24gb24gDQp0aGUgQ1BV
Pw0KDQpJbiBhbnkgY2FzZSB0aGlzIGNoYW5nZSBjYW5ub3QgMTAwJSBmaXggdGhlIGxvY2t1cC4g
SXQganVzdA0KcmVkdWNlcyB0aGUgcG9zc2liaWxpdHkgd2hpY2ggc2hvdWxkIGJlIG1hZGUgY2xl
YXIuDQo=

