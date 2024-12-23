Return-Path: <stable+bounces-105635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2D9FB0DB
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544691883E11
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E71ABEB1;
	Mon, 23 Dec 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lM3F+8DE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CD1B0F30
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968708; cv=fail; b=Zl+PjrdmJNh86qVb5Z5gcaolISKKUYFrC4n3mWRpqG3MePgVVkG5J5g3Hx0tRB4rT08sOzaFWr8IYJ/v4YG8o5gb3fgNnL6DwSLjuo+Jk1zfZWw6YAk9GVPYcX2bBbE0olui41miPTosBQExKxwtc06Rj679qW9itt3dwikI088=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968708; c=relaxed/simple;
	bh=It+4aOo5FAtODBIis1S0jeGgaz+MlW6cROCEiy/slec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlV73JvCLOSXWLero0vIyzh3BAksl0mt55aCBLgwMeZg6AkoqVOlDMm3Q/erWnNGqs5oIhNiW1mOoqJS9EGolaj9UU2f3aulthWLPF7Rfk5glb26kbpLAMhbRNtrJKgWAnMJK3vEVaDO5X2Tkw3ZjuWRRs3jzTVhUMHWKeWugT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lM3F+8DE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734968707; x=1766504707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=It+4aOo5FAtODBIis1S0jeGgaz+MlW6cROCEiy/slec=;
  b=lM3F+8DE/9e9pU7tXtSRP9URmbb1gjuuSXjcbE0sbESyw3M1TZWlI0cJ
   8IqAKw8OiJ7hpRrT2T5H6WgzFbT5yzAEWaar73XI1BwGd94xoEv3VHXs6
   bl7XJh8lukNw9YSmQzko4DWx+fmPV7/C9JIYvesp6yf/YbF33LQiUdEVL
   U+LFktRp5YqWKG1y6qC7dr8Ep1dHSDuh5dsxfll8/ukhpU2rdB1i18zlj
   tmk5HXfvLpzlUUQn/d3Xrd0zkeerxpTYEgWgXSYnKaQFsNtcjozCm9xl0
   pbIr6Cu7vqar32w1rnj0H+kpyAeBXmDSa1KQTgzEk2otYdMA54GC1GtdS
   w==;
X-CSE-ConnectionGUID: 6THhxGuJQ82wuzCHLxUBpQ==
X-CSE-MsgGUID: hEJ5ROYUQmWxUyTmgRFeew==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="38275683"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="38275683"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 07:45:06 -0800
X-CSE-ConnectionGUID: uXoq4Ll5Q4+sqtuuiNalTg==
X-CSE-MsgGUID: 6nPAr9TmTeK8+/M5DMsE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99603406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 07:45:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 07:45:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 07:45:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 07:45:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie23PTfUviAunE+3VHtGATDpsngC0qTb1BEQAMc/+hasXiZcu273T9A4IdN2oEUhvrqGKJBb8+E/7hQr72IkGDRQnqb9D7ygT65UUwy8mbkER55R1kF9JzcvXSxjOZbNrG1egj2xH5E6iDEGqz3L7ysnRsd1lfb/BfmZ/YoZPSkkSjFP/WpArsDoXcqZzDWE5070wlYvN9EsUjsaL9Djy2423BRPf3LQIiP2RPyjeKq/e3LxC7M8/Q3coaxZB4d1kmaNodt8ygWNfwA/cS23a2Ij7PdbiBu5btHh2S9NeRdkRNAFVAF9Okrjdenry9vZ3jXJMU6+C26yQ+aQE84W2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It+4aOo5FAtODBIis1S0jeGgaz+MlW6cROCEiy/slec=;
 b=Oq1vp4MJHjwN2LiQWO0YtfKlcaqlHKiXLrI+AD866SbPAt8o9FSMq75zq1eP5GE9g1WyHOqnV8ZJSZQvWW5LFTMzNQYT5S4EBtWXXPQ1K5AFA1uriLcqjX6sE2xeZ2fnlrq+lrNkINxhHpUWLTtrMB0CLGkBgiuWR1bZKXYUrnL6kOdxJk+m66BU0zCzQ7bjJmWgxHxSiBzCj6ZcBYxPPQWOD6ECnHcuwF5QUIkm42JJ73nGtEhw7LrbV1H86wgHD6yOreP+qGaqmus62GnfFnfrV89lNQyg/3b+PA6GR3qsXH1JtuU9ZE0w0xD8QiiDhfyQvLM3NdyxMOokEpxRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 15:44:59 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 15:44:59 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Sousa, Gustavo" <gustavo.sousa@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, Radhakrishna Sripada
	<radhakrishna.sripada@intel.com>, "Roper, Matthew D"
	<matthew.d.roper@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: RE: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Thread-Topic: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Thread-Index: AQHbVUCsgs+ZYtk5+UGoWikD9+c/G7Lz9ltw
Date: Mon, 23 Dec 2024 15:44:59 +0000
Message-ID: <CH0PR11MB544474672DC3D24C193A12B5E5022@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|SN7PR11MB7068:EE_
x-ms-office365-filtering-correlation-id: 392ce94a-8edb-4f68-8eef-08dd2368c1ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkVLaEk0MnRsSEV1empETjdHQk9uaGhSQ2QvYkZrWmlNWUV6dWpTYWxadDFV?=
 =?utf-8?B?RUdYSHllYUtLSWJJaVpFRXIxY25Pa2RyVmVhbjN6V0RaTUVNemRrM1d6Tkxs?=
 =?utf-8?B?dGdzWVFjM1ZHMmNrOUN2Tlg2cEVjVkhtenM2ejErSGxPMU93ZTZzMzN4ZGZK?=
 =?utf-8?B?TE9oZWZNODZ5RUVJVFh6WnNGVEJKVEtUUmwycWxSWmhSQ21SUjIvQm5uY0lp?=
 =?utf-8?B?SVRaOHJkRkN4cFZRNGVKZ09Rd0dnSzUvK05Ud1psNTZoS1cxN0QyQVBPNWxi?=
 =?utf-8?B?b1lrQXRoZzdUOGNEL0dSNWd1aTlpQmxNcEkzaXJrcGh1R1A3RG5pVkVyM1lu?=
 =?utf-8?B?alkvRkJuT0dxejBNa2doMVpKVXFqQzBsb0g2N2pjRXB0MzJZVk01d0x5T0Rh?=
 =?utf-8?B?N0dXVVJnVzFzUldaTHlXTjRDeHl3QjBPdzZ4YjBEeHpFamw5ekdVbThSOFRl?=
 =?utf-8?B?bWUyUFA3d1hnRTRJM3VpSDR0VHRpM0gwa1lleGovK013amh4QzN1czhrZGVu?=
 =?utf-8?B?K3gyeDVxcmprcW1ncC83YjZmdmtMcVZXT0pDMXlmK01QaTZVSkl0MnpkRWRn?=
 =?utf-8?B?QXp5dUtuWUc0Y0Nmb21FMzBuN2FuZk5aMllkYk01M0J1b0VLa0ZscktlL3Rw?=
 =?utf-8?B?VVJPREJMUTh3STU3aXNHaUxTV0pIYmxCeGp2YzN2dTlnVVpOR3NsbTRFN2cx?=
 =?utf-8?B?VWIxYlpJemVpcE1hQWwxVGJzR0l5ZkJ4TlRnUk13Uit3RS96dXgzS0hVb0Yy?=
 =?utf-8?B?MHdkK0ZRMUJjdWNzb3IxK0FzQ1ZOcEFLOTYwa3NTNWtISGwyblRzSGJtS2VD?=
 =?utf-8?B?UUNjYi9rM1hrNXJGbFJCdzgxYnRGbmRvYkxvdEN5UXBQRjdFYXE3V0l1Z1VT?=
 =?utf-8?B?dzQ3T1hvQjBlQTZMbmNYem54NEhlZkNLS2lyR0tnS2xneUx2QzdWL3gvZlJq?=
 =?utf-8?B?ZVhLUDVCaHErL2FvTjB5QkMrNWFhdkNjR2cyRmJoYUlEaVJUZUN3ck9CNWxL?=
 =?utf-8?B?VFQ4TGpML01pVm9IQmh0M1pxWWJVdWxyV3hKaWlKajBCYmhTWi90Z1FWdzdr?=
 =?utf-8?B?VmdXTHJwMmRqQWp3SXlXZ25Lb3RzSVJOdmNuVjVVdGw3clhmUnA5RU53Zlp2?=
 =?utf-8?B?U24rdHJuQ2RQSkpHVzRKUUJud3ZJNEl2bDlYdUQwRDlPeXc0aG5SN01YTFpI?=
 =?utf-8?B?Q2NySVJhMktCSEJEcjNPc0N3QmxHZUZlWE93dDhyaXovWjErS0pPRGtkRUxG?=
 =?utf-8?B?R0xDQ3lQYTFMQzc4VWpVOVE3Nm9td0NBUjI4V0g2aG5BVWpLYUZ1LzNYNE9y?=
 =?utf-8?B?K1UxMDVicFB4STZlc1F5QmUyb1R0OEpZenYxK1ZDNXcxcjdrRGVBRUhLSXNV?=
 =?utf-8?B?YjVLSVlMNWs1NmJSLzc0c2VPQ3FCYU5nTWFHOU9HV3cvVko3ZXUrK09qNTVh?=
 =?utf-8?B?elFPK050VWRiNmJaRTlxVDlHSGJVR1JmanRRVm5LTnRZTVkyc1hUdG1XcDhk?=
 =?utf-8?B?QWRETklsQzR6M2FENStHNnZSd045cFFLVGJnRGZzNlpLRm92Rm5ES2xNYWRS?=
 =?utf-8?B?TzY4L3k0UVNxNjIvRzVUeHRBZ3dtRVo2cmJkeWxTVFZWUGZpZVdpOXlBUlp4?=
 =?utf-8?B?L2dZUWh5d01DVkpUcWMxWm44Njd1ZittUnVYOWhpbDdEQm4zSnlhTW5PNnVu?=
 =?utf-8?B?cDdvZUtiY0E1Y2c1TWtteVRMVmZWOWZkelRDTHA2ZE9sTHBjUGNscHFzTjlx?=
 =?utf-8?B?TFd4czdKV01jZlVTeUF6Q2UrRUp5aVdrVTlWYWVXM2tzcnBNSW5JdklkY0pH?=
 =?utf-8?B?RnYxc2JiaWFrK3JjU3RTTnhpWWM1ZTZlUkFYNW5kWWNhN3lveEVkR01Yclpt?=
 =?utf-8?B?ZXhYb2N2cmdhamdIQVBML3dGd0xYTEViV1RueW9XeEloN2lRL2Y1UjBIUmpB?=
 =?utf-8?Q?3cXHIBF/VVql2yTWhqTYBhFLs7MKt1r9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5RUDZsV0FnbVpJeDdMQ01KV0ZKMlY3NkhiSERkZXJnejdrdTg5Zy9vSTQ3?=
 =?utf-8?B?RFA4dUVEZ2VhT3pZUHhoUU0yZlpiVXBObVdKYzNMUzIvUkYxQlJ6VVkwZjdB?=
 =?utf-8?B?L0c1c1ZTQnN5dW5PRTREVEtXWUVUeExPQmE1Wm0ycml0aUU5Y3dGU3ZiMnp4?=
 =?utf-8?B?OHQ3eUk1QVRxWmFaMHZiZ29hcFczeVNZUmZsN2EvbDIvbXNHcEtZTng4eU5P?=
 =?utf-8?B?b29aa2t1ekdHT25VUk9mVGp0UEw1TFBwSnU5WWpVcTZUVDNwRng4eGFGTjRY?=
 =?utf-8?B?ZmZGMjFHYU5ZbzdnR1VrNUE4VGx2WnpVMmFpeEN6YzNQVGcxSmFMaFZta2hJ?=
 =?utf-8?B?WEJQUGliUXJDOE04cjY5UDBxY1ZpZms1WGZvMXNkay93dnlvamUyVWxDdXhn?=
 =?utf-8?B?RUJ3UUFJcUEvWm1tMmxEZzFyZXMwLy9zSHNmYkpqdE0zTG5wUzVZYmNqTnVN?=
 =?utf-8?B?SEdhdVRYUFRscEVOL3NKWDNQSDh3a0gzK3VKa1V2eXhXWGZuVkJtN3JvRGpC?=
 =?utf-8?B?d1dPbWcrK0VEVjRiY2VKcXFBY0pwUTVGaXpmaEt5bThQWHFHbEl4bzhKRUJy?=
 =?utf-8?B?aDAraGVURTJsQ2xDdkxuUFBDVVVZTG1OSFJyVmpRM256aDJxZkRaMzdDejZK?=
 =?utf-8?B?eE5RM0lVU1I0TVgxL3l2aEZTWlRBWUJ1SE1rWWkycG1KTnRuUEk2YlhyTWUy?=
 =?utf-8?B?eEFBZDlDRW9kam8yQU5BQXBoZDcrTVNWaXdLMlhhTU1wdFhOQXNpNXd6Y0tK?=
 =?utf-8?B?ZWo2UHM1ZHJyeG5TRVU1Z01TaTN1VlozNUtTRHVyUWI5cHN0bkFhV2xTSWFK?=
 =?utf-8?B?c3MzUFNtSVI1bTdZaWdZYUZ3MDhYNnN2Qi9VeVROTmlRQmZVS0tWWnY0ZWFL?=
 =?utf-8?B?WEg5SVRWci9qWXU4R2tVOXJlOWpRYXZDR0xNa1IwQ01lVFlJYnovQjUzbW1X?=
 =?utf-8?B?azBZaXFjd3dUcWxLcVhMNzlqelU4L3UweHlRV285VndyNkJXSTVzTDZJT3hY?=
 =?utf-8?B?YjRZaGRBeUxENG41MDVXV2xpcW56T3NjZ2NJS09VaXRtMnJubWhXVE9iMkli?=
 =?utf-8?B?eThFd2FrRmJzSkFxeGdMQkUwandLc2RDeGVUb0ZKenZ5NlVySFNIMzVaTTE1?=
 =?utf-8?B?WVVlUExJOUZSRjBnSkkxcUNiNnBvZTFLWFFVRFhNQjg2Y1Nod2U2bGFhY2VH?=
 =?utf-8?B?ZUlTUHkrV0ZZbmo1ZlZDTDcvT09ZSnh3USs1aGtoM3ZVT2hZK3dRc3RqeFg0?=
 =?utf-8?B?bzlsRERMdTVHNUpUQlFqdEVuc0FIRnZTZUhYeVdWOUlXNUhwb3Z5cTdPeVo5?=
 =?utf-8?B?L2oyenN6Qk5vRkJRNWxYcHliRDdVUzVWS2JMTk42NU1Hajh6VHYwZ2U3SXNz?=
 =?utf-8?B?RGZvOU02cHh1Wm5HZ0Z3Q0ZiWkRGalVCbTVjM25tTUpaTm9RNEVEcjRyQWgr?=
 =?utf-8?B?a3RrcmhqOWdjY1Y3T1pTYXk1WVFTYnNiY3JWcW5Ua2I0cWlSVUs2OHQ2Njkz?=
 =?utf-8?B?dkg1VUphNDk2UG9XVEluVkRveVlhWFlESFlFNmhoSVI5ZitmdUNnbTNyVGdU?=
 =?utf-8?B?dUY2S1ZOYmFWU2JWN0F0YnJtYU5NcXlGTDFzamZHeVBHSm1FM2tRSHE2WWlD?=
 =?utf-8?B?ME55bk53L0lUTWlvTk9FeWk3WHR3MGxCWDNFek56cmFhRnd3a090MDkvZU5v?=
 =?utf-8?B?cEVlTnVjRWNyRk85YytlK0ZoL2lycm9Uc2h0UGV6WTJaTnhaTDMrZnRvRzYy?=
 =?utf-8?B?UDFlVzh0bW4xcDllRFhmVW9RZjh5V01EZlZ0Y0dQTzl3MXFHTzV5WHNRclVN?=
 =?utf-8?B?TkVCNGZjR1JTamRFMzdVa2ovZGRmTndwOGRZSkNTNmRuYXlIRkJybTJxeTFp?=
 =?utf-8?B?bi9QcjJsS2FnbXRpQ2pmQmFsTzJKcGVNS1hmNGxuenk5Y01PQXlCcHNBN055?=
 =?utf-8?B?dmM1ZjlvSE9IMjQzWFNVRzVmeEdsT0ZqdnZGK2J0N21XNEY3eFc0Y1krMjBY?=
 =?utf-8?B?dTllR2hYY0hCTEw3MGRZajJDTEt4YWpnR3BMQktFS2gycGV6VXBXMm9tQWtZ?=
 =?utf-8?B?cDZESnRSVitseGd2dG9tWlhDNzRIcUtpZlJLZ2Z1U3BvbWpjZ3M3NC9vbEdS?=
 =?utf-8?Q?mDEUj5HGtD3iOvqyS2CSmueyb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392ce94a-8edb-4f68-8eef-08dd2368c1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 15:44:59.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GaCWExJDtWMLCqo81243FsN5gwZMTEeDlNLYgEVX1LyG8/nXrcKbDtbdp7zYa3p+O8NfenC7BdxoNMa/cbxmUkAM0Jtq1RDQPUWAlZfNic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEludGVsLXhlIDxpbnRlbC14ZS1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFRob21hcyBIZWxsc3Ryw7Zt
DQpTZW50OiBNb25kYXksIERlY2VtYmVyIDIzLCAyMDI0IDU6NDMgQU0NClRvOiBpbnRlbC14ZUBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxz
dHJvbUBsaW51eC5pbnRlbC5jb20+OyBTb3VzYSwgR3VzdGF2byA8Z3VzdGF2by5zb3VzYUBpbnRl
bC5jb20+OyBEZSBNYXJjaGksIEx1Y2FzIDxsdWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+OyBSYWRo
YWtyaXNobmEgU3JpcGFkYSA8cmFkaGFrcmlzaG5hLnNyaXBhZGFAaW50ZWwuY29tPjsgUm9wZXIs
IE1hdHRoZXcgRCA8bWF0dGhldy5kLnJvcGVyQGludGVsLmNvbT47IFZpdmksIFJvZHJpZ28gPHJv
ZHJpZ28udml2aUBpbnRlbC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBb
UEFUQ0hdIGRybS94ZS90cmFjaW5nOiBGaXggYSBwb3RlbnRpYWwgVFBfcHJpbnRrIFVBRg0KPiAN
Cj4gVGhlIGNvbW1pdA0KPiBhZmQyNjI3ZjcyN2IgKCJ0cmFjaW5nOiBDaGVjayAiJXMiIGRlcmVm
ZXJlbmNlIHZpYSB0aGUgZmllbGQgYW5kIG5vdCB0aGUgVFBfcHJpbnRrIGZvcm1hdCIpDQo+IGV4
cG9zZXMgcG90ZW50aWFsIFVBRnMgaW4gdGhlIHhlX2JvX21vdmUgdHJhY2UgZXZlbnQuDQo+IA0K
PiBGaXggdGhvc2UgYnkgYXZvaWRpbmcgZGVyZWZlcmVuY2luZyB0aGUNCj4geGVfbWVtX3R5cGVf
dG9fbmFtZVtdIGFycmF5IGF0IFRQX3ByaW50ayB0aW1lLg0KPiANCj4gU2luY2Ugc29tZSBjb2Rl
IHJlZmFjdG9yaW5nIGhhcyB0YWtlbiBwbGFjZSwgZXhwbGljaXQgYmFja3BvcnRpbmcgbWF5DQo+
IGJlIG5lZWRlZCBmb3Iga2VybmVscyBvbGRlciB0aGFuIDYuMTAuDQo+IA0KPiBGaXhlczogZTQ2
ZDNmODEzYWJkICgiZHJtL3hlL3RyYWNlOiBFeHRyYWN0IGJvLCB2bSwgdm1hIHRyYWNlcyIpDQo+
IENjOiBHdXN0YXZvIFNvdXNhIDxndXN0YXZvLnNvdXNhQGludGVsLmNvbT4NCj4gQ2M6IEx1Y2Fz
IERlIE1hcmNoaSA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29tPg0KPiBDYzogUmFkaGFrcmlzaG5h
IFNyaXBhZGEgPHJhZGhha3Jpc2huYS5zcmlwYWRhQGludGVsLmNvbT4NCj4gQ2M6IE1hdHQgUm9w
ZXIgPG1hdHRoZXcuZC5yb3BlckBpbnRlbC5jb20+DQo+IENjOiAiVGhvbWFzIEhlbGxzdHLDtm0i
IDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFJvZHJpZ28gVml2aSA8
cm9kcmlnby52aXZpQGludGVsLmNvbT4NCj4gQ2M6IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTErDQo+IFNpZ25lZC1v
ZmYtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNv
bT4NCg0KSSB0YWtlIGl0IHdlJ3JlIGhpdHRpbmcgdGhlIFdBUk5fT05DRSBpbiBpZ25vcmVfZXZl
bnQgZHVlIHRvIGEgdGVzdF9zYWZlX3N0ciBmYWlsdXJlPw0KDQpJIGRvbid0IGtub3cgYWJvdXQg
dXMgaGl0dGluZyBhIFVBRiBoZXJlLCBidXQgdGhpcyBmaXggaXMgZXhhY3RseSB3aGF0IHdhcyBy
ZWNvbW1lbmRlZA0KaW4gdGhlIGNvbW1lbnQgaW1tZWRpYXRlbHkgYWJvdmUgdGhlIFdBUk5fT05D
RSB0aGF0IHdlIHNob3VsZG4ndCBiZSBoaXR0aW5nLCBzbw0KdGhpcyBpcyBwcm9iYWJseSBjb3Jy
ZWN0IGlmIHRoYXQncyB3aGF0IHdlJ3JlIHRyeWluZyB0byBhdm9pZC4NClJldmlld2VkLWJ5OiBK
b25hdGhhbiBDYXZpdHQgPGpvbmF0aGFuLmNhdml0dEBpbnRlbC5jb20+DQotSm9uYXRoYW4gQ2F2
aXR0DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfdHJhY2VfYm8uaCB8IDEyICsr
KysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdHJhY2VfYm8u
aCBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV90cmFjZV9iby5oDQo+IGluZGV4IDE3NjJkZDMwYmE2
ZC4uZWE1MGZlZTUwYzdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdHJh
Y2VfYm8uaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfdHJhY2VfYm8uaA0KPiBAQCAt
NjAsOCArNjAsOCBAQCBUUkFDRV9FVkVOVCh4ZV9ib19tb3ZlLA0KPiAgCSAgICBUUF9TVFJVQ1Rf
X2VudHJ5KA0KPiAgCQkgICAgIF9fZmllbGQoc3RydWN0IHhlX2JvICosIGJvKQ0KPiAgCQkgICAg
IF9fZmllbGQoc2l6ZV90LCBzaXplKQ0KPiAtCQkgICAgIF9fZmllbGQodTMyLCBuZXdfcGxhY2Vt
ZW50KQ0KPiAtCQkgICAgIF9fZmllbGQodTMyLCBvbGRfcGxhY2VtZW50KQ0KPiArCQkgICAgIF9f
c3RyaW5nKG5ld19wbGFjZW1lbnRfbmFtZSwgeGVfbWVtX3R5cGVfdG9fbmFtZVtuZXdfcGxhY2Vt
ZW50XSkNCj4gKwkJICAgICBfX3N0cmluZyhvbGRfcGxhY2VtZW50X25hbWUsIHhlX21lbV90eXBl
X3RvX25hbWVbb2xkX3BsYWNlbWVudF0pDQo+ICAJCSAgICAgX19zdHJpbmcoZGV2aWNlX2lkLCBf
X2Rldl9uYW1lX2JvKGJvKSkNCj4gIAkJICAgICBfX2ZpZWxkKGJvb2wsIG1vdmVfbGFja3Nfc291
cmNlKQ0KPiAgCQkJKSwNCj4gQEAgLTY5LDE1ICs2OSwxNSBAQCBUUkFDRV9FVkVOVCh4ZV9ib19t
b3ZlLA0KPiAgCSAgICBUUF9mYXN0X2Fzc2lnbigNCj4gIAkJICAgX19lbnRyeS0+Ym8gICAgICA9
IGJvOw0KPiAgCQkgICBfX2VudHJ5LT5zaXplID0gYm8tPnNpemU7DQo+IC0JCSAgIF9fZW50cnkt
Pm5ld19wbGFjZW1lbnQgPSBuZXdfcGxhY2VtZW50Ow0KPiAtCQkgICBfX2VudHJ5LT5vbGRfcGxh
Y2VtZW50ID0gb2xkX3BsYWNlbWVudDsNCj4gKwkJICAgX19hc3NpZ25fc3RyKG5ld19wbGFjZW1l
bnRfbmFtZSk7DQo+ICsJCSAgIF9fYXNzaWduX3N0cihvbGRfcGxhY2VtZW50X25hbWUpOw0KPiAg
CQkgICBfX2Fzc2lnbl9zdHIoZGV2aWNlX2lkKTsNCj4gIAkJICAgX19lbnRyeS0+bW92ZV9sYWNr
c19zb3VyY2UgPSBtb3ZlX2xhY2tzX3NvdXJjZTsNCj4gIAkJICAgKSwNCj4gIAkgICAgVFBfcHJp
bnRrKCJtb3ZlX2xhY2tzX3NvdXJjZTolcywgbWlncmF0ZSBvYmplY3QgJXAgW3NpemUgJXp1XSBm
cm9tICVzIHRvICVzIGRldmljZV9pZDolcyIsDQo+ICAJCSAgICAgIF9fZW50cnktPm1vdmVfbGFj
a3Nfc291cmNlID8gInllcyIgOiAibm8iLCBfX2VudHJ5LT5ibywgX19lbnRyeS0+c2l6ZSwNCj4g
LQkJICAgICAgeGVfbWVtX3R5cGVfdG9fbmFtZVtfX2VudHJ5LT5vbGRfcGxhY2VtZW50XSwNCj4g
LQkJICAgICAgeGVfbWVtX3R5cGVfdG9fbmFtZVtfX2VudHJ5LT5uZXdfcGxhY2VtZW50XSwgX19n
ZXRfc3RyKGRldmljZV9pZCkpDQo+ICsJCSAgICAgIF9fZ2V0X3N0cihvbGRfcGxhY2VtZW50X25h
bWUpLA0KPiArCQkgICAgICBfX2dldF9zdHIobmV3X3BsYWNlbWVudF9uYW1lKSwgX19nZXRfc3Ry
KGRldmljZV9pZCkpDQo+ICApOw0KPiAgDQo+ICBERUNMQVJFX0VWRU5UX0NMQVNTKHhlX3ZtYSwN
Cj4gLS0gDQo+IDIuNDcuMQ0KPiANCj4gDQo=

