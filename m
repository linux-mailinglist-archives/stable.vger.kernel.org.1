Return-Path: <stable+bounces-223706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAoyOtX5rmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:48:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7C23D087
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E0D302AF30
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ECD392809;
	Mon,  9 Mar 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbnoheKe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A012CD8B;
	Mon,  9 Mar 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074299; cv=fail; b=HGSO0rtI7wrFNt1M6l92yhGsyiXXip19WEmMDcKmg/Ux8HHYzEm/tKfNk72qlUA+zPZ5yy3oSREHOv5oV9qK11B64UQQIE4dMeo5dGssRdek9qLVM6Y1aE2yxtlCFkDImAO3PHSR7If4tap49t0jxNDnYLyoB5c26/nODfPdhP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074299; c=relaxed/simple;
	bh=1w1OdZp8g91rnLFu3F+WotvUgJc7kjoHHU11Y0zq5yE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c0a8Ru/ihM/Ii53ZydnyQrICq9QgggqR0MJuDptovQMwxZOkHuVTct16l1nfVk1B7Y1s4AbHTl9KEiHAgMS8aYpIXqNiF1YDxOyvt4SaklxW8fMXy8EuyxzFhXlI7woyHmFWdUxR+ubodNaDJF+AHxji5YE3wGAqQ8lhZn/EJ3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbnoheKe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773074298; x=1804610298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1w1OdZp8g91rnLFu3F+WotvUgJc7kjoHHU11Y0zq5yE=;
  b=nbnoheKejVB0u5W6R0ueaMv1dpjwQuLw5OYq/GLQqTcjvlPZ6+LQEHPx
   5jukATQ82jmCxGN7sDbvBEHFtr1YPtFoYumU2yWcnwBo+ZwJdiRytTY7b
   N/HrAAngPb6TAUVGAFn8R4K0aosdv/R9KdY8NIzD0lReIGqMI5rF7l3FI
   +AUuajTQ2VD7uxv8qYIdwiAJEYx+QgvNqjJp39w+UloONDwuqOtdjhGPj
   UP9fVMg/N8O2+U2i1Qiv0uTo1mYbUKRPh2nMh15FhVN5Rn+ECYedwRUej
   S1nsTVmxdOQMn/gfRrfHY5aVyodDi4YE5OGfjHBZIocc6VLIGmFXdeRS6
   w==;
X-CSE-ConnectionGUID: E/b797FhRVWoZOz2bNV9XA==
X-CSE-MsgGUID: rbT1OdCXQguecgUijwiSTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84431807"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84431807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:38:17 -0700
X-CSE-ConnectionGUID: RWboIX3sT2ur+iT8GjxuKg==
X-CSE-MsgGUID: +z8ebBrDTDiHYYUFxn98Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="223926405"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:38:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 09:38:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 09:38:15 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 09:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpVMp7JAcdM5le/x4Cb/g4Kk06hrj2nguPYtFf4TNGKsfeI5tg6oSoaJDIZCFDuS1CCviud7ThLYonJufJjsyyYJJE5ReAsvALaP3EHoco16ukvhjL9VQGDtRvlNtKx/pLNvO6wTannjJyAIzyXghlraCZHwfMdosuCX1rg5VsnlNn/dJiaJwMM/nx33FG3QGYXa6CKcNAwyRsVd3N/jcJJPWTC7M7K0kiqYVfqJ+Rs34HeKwPF/hVpR+P2suWteFCZq6BONBFonHyHdNapvZScvwFYkMSWnk/39wL0fl8RAOu+HodQKZ2w82g7wtDJYgG8NmIwqHrxpAovswoAvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w1OdZp8g91rnLFu3F+WotvUgJc7kjoHHU11Y0zq5yE=;
 b=kfIxqtOFyDCZkUhbzpgNXfVOY2zGCM/85thAcnhfgdrPtlX1jiSoBIKTc2TUCf6x6H4bLGQCUx2YblloJQsDsnzSsUaggsLHGGVIJpA8pTFvfCdPBYtKYaaDs/pFwKBqHBlqZADHnDLdEcMr1VVV6r1KPI3ZnNfD8zLeZiqK+yrJ19O+f5kxX8cOCehggixifi5kCcFP5CgOVPin/41MQ+WvHOROYw1C6HPVpA5vkQrbcz/PsXMELk6bBJBC44I5kMcFQAJWBMLcYPD1R79KxeLGvL74UL0g44J8mHcer4RhWGgoAQIQPJMDYytyIiA9aVb9hOVDAthVpiLBmXP4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 16:38:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Huang, Kai"
	<kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6VnrQj2eoJJUyFZAbVY/MSfrWmck0A
Date: Mon, 9 Mar 2026 16:38:10 +0000
Message-ID: <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
In-Reply-To: <20260302102226.7459-1-kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6838:EE_
x-ms-office365-filtering-correlation-id: 24c29821-1698-47b0-a4bb-08de7dfa3ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 1e2O8U6wPc9Nyfer4ccNTYTDejZHzQlYxrXRtV6tqppCPdg82eR6bTjk1Erka2AWgHOY5pgxJFw8ACmi3D+LBA/4/zA3r999b/x7TNdNSBWMm/VS0+mt10ZdZeR5bv5JFU212JV74z0nqSLNXWwetgpDhxO5AZtXTVM5IFZdK3L4ySxs1MOtPK9tznrbN5AbEjahxe8eNtBRNU0sVyxHXlna76lzqxEyQa9NY27j9/BGIcPI+PCDUodG5WltlvAQTyaNKilMDAwyi4sgoGZ6LV0asjnUxByfaAIMDpmtNcuHvnLEihVi3oTqNkTT8o3H+fLU9QglpZisoNYj8QvF2XCT3bVSD5wgZxmLKWHaAytOpTveJ1PMZ9K3M1GhEe46M+gpdHVhBoQOGBB01yFg3IFGUVNIXVN3hc6hmIN3FyP3ibNd3CamaTDxERQa9Rv0tOsuiNDEB0JNpvt9vQ2+ki6hmTB9gVXJW4WCLOnKE+Oultl76+l8mL94oygPDTCZXtigglYYA5IxiNCm+d5eEFarQsSoeOjGGkMseNGR3S4J47wcW4JpFePiqLV6lV+oD0oCxhg+eg6y+9TNkVYR5CUSvJR2zCDEGWv99ylONTXmTd9pMJnJL2eZXV5r8NMH+CoMPzA7zZakCH7R1i+v9u6fyZo4NMkr6MZSaCeTjZwJH/4BstBqgh2W1kd6TsX501VOW8EmcWquDMejFNwTElBR9uyfvFL642kvSrE1nAKsWSlH41MnOhgHVKUihuCpB8yEBeJ/24DcP0e5P+SG4wi7tQ/sVTOT/p7Yy2To9kQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blN5aCtneVBlajN1ZXRFblJ0R3JFby8zS2NiTHowanRySml1NHFMT212K3Bw?=
 =?utf-8?B?d2V6Qk53eldQMXZkN1dBRmRpUitKQThBWVN2ZTJpNm84eHRUSkk0YkFwMmxP?=
 =?utf-8?B?RXlCckFNVTAvb1U3ZGR1OS9Ua2Jtd054R3lVcWluVjArWlNLc3dkUFdnV3Jt?=
 =?utf-8?B?VHBUZW4ydnBsQVF0aTVhZTFicUxBMFFYZXg4WjI5dHBOb0RydHAvd2JLeVg3?=
 =?utf-8?B?bUZ2TnlnSjdNWFZJanRaNG84L0xYajcwRkIvTFBNS1JrOGZoZExvU1lIM2NK?=
 =?utf-8?B?K0tqb1FYVnN5WmVHYlc0bm5CMG1LU2RTSVdYa25GQkx6L3Zuc0cxQStCREx1?=
 =?utf-8?B?Sy9sSlJLbFNuVUV4a1hOUjdEYktwUjFWN053R2MrZldhZ05yVEVEQ3hMM293?=
 =?utf-8?B?YmFhSVRuUlFZV290L0QrUE9CalFmTnZpVm85NElVS2grdWdBU0tkNUFxZnBS?=
 =?utf-8?B?amZYVmx2dHVSdktTUXdIMDAzNHNvdGdjbU9hTnM2WGJoS2xOaUsyL1VQVWQ5?=
 =?utf-8?B?NHliYy9vSUxzVXMxbHpTWUx6bEpqdyt5WUdaMmdXVlB3SDdhWVpMbFZpeE9F?=
 =?utf-8?B?RnphTm9tM1d4Z3E3NlV3dmFuS3YvU2ZOU3hLZHNweWZBcit5SkRwMzExZzl6?=
 =?utf-8?B?NkVoU3ZoZFJnMUpQd1lRQVpPUlhidkJEcFAzeERYTmlZZ1NmbU5xYjBzd1No?=
 =?utf-8?B?TXE2NWxJa0hYWXIxZVB4TCtMQm9UUmwydXZqd29zbHBnOHZQdHBpQnFxNm1J?=
 =?utf-8?B?Zk9BRlFGUVRQNWd0cmdDdGdKM3E0V0xOZWdCUzMyUGl1bG0rdHZYT3Ura1R4?=
 =?utf-8?B?dzZ6Qngzd1dnZ1RkdUg3WFgrY1RnUHRPa3NXb1VOZHdkbDl5blVMdFg1NFdG?=
 =?utf-8?B?L0szV2lkZ1hMMFgwVHdOUjc2TGQ2RGJQcHBQcDVyc240N25BcUtGMGQ5TkZ1?=
 =?utf-8?B?YlNuMndGd1dFMGp0NnY4OGp6QW1oaFpLUlZJMXg2cThPSXFqY3hEc2lST3Fp?=
 =?utf-8?B?anRlQnd2c2tIcW1PUGVWZDNVbW1vbU5UKy9BZk1JcUQ4SGM3dkt1R1hPendK?=
 =?utf-8?B?WDlIZTljcDVncEMvekNkSlVIRExUd002Rmk5UjFLdHVMUVhQdWFDY1ZJcWdT?=
 =?utf-8?B?MDBIWDZLQjZ3WUlYWlVRb243aStqN0JyRkNjRDVJQVBDQUxVS1NHOFl1R1Fo?=
 =?utf-8?B?N1N4aUtKNkk3a2dXMW44UnhCYU9OWWh5UERGZDZjVDYzVjVLWWo4Mng5WU55?=
 =?utf-8?B?dnVPUzdnL3VwU2Z5QUN6T1hJem15MmZMY3lheEJhWVN1WVNVUGN0aE83bk1D?=
 =?utf-8?B?T0lNMlB6aENwa3UyRG1tVlU3RyswQ0drQ3BWSGtqUWdzK09jVy9aS0pMMmNk?=
 =?utf-8?B?MU5hRXVISnJNODFuem45dnUxVENWOVdMRHQrV2RuSjdRa2tXUVg5TUoraUZC?=
 =?utf-8?B?UEJFNmtNM3NtMU1xWTUxZWM1bGwycjE1cVlHWE1WaHhBaUk2VU1HZlR0MzFI?=
 =?utf-8?B?SEQ4YjJzNjkvSjlTazdPMTVQb2dUdXhxS0lVS3lOTlNORUJSazYweWZNTnZi?=
 =?utf-8?B?dUNTOTcwbHU1MUQ4Qi9vS3dlbDc2K1hlTHBETmY4dzZ4WUd4ejdnZTRneFFk?=
 =?utf-8?B?V2cwYjJ0WjY5cEQ2S24wamJ2S3l2ODhWUG5zTVZVNnE0Um5WMDZmQ2xMcGQ1?=
 =?utf-8?B?b3lZcDFXdFFFVElnbU5uNWFMT21rbFRBWjdEUkRlWEk0UE9BSUpVNkN5cUlt?=
 =?utf-8?B?bjg1VjlDT2FLaHMzMjBuYnJlMklaRWNlZ0hzRzNxR0M5aXdUZjB3SlV2TnhM?=
 =?utf-8?B?VmMwNTJqYTRPemhJSXlhbmtGTEp3WFlPSDNWR0YrK0d5MXBqY0oreURlRG8r?=
 =?utf-8?B?TlcyS1FBcGlMMzVaYkFZU3BhWlpWbHcwN01tRU41dnVKNkZPaUNlNWRnenlo?=
 =?utf-8?B?RDNtL3RXUVN4RnUxOTdyTUxPVXJlOGIxVW42dWlVWTZKcDJKQnRvenc3WE5z?=
 =?utf-8?B?N3g1WWRSeTY2dWZFaHEzeUl1RjJwN1VsWUUxOW9kL1ZOWWs4VlcvNmI4cTVj?=
 =?utf-8?B?UTgzLzdMczFhVFRRb2taV3Nkb0FrUGNYWmRTZnVjeFFHeTdncytDK0lMalRT?=
 =?utf-8?B?Wk5XbmJFSmZXYmF1M2gwR1M1ci9mRUlPbHY1L3JJV0RNcW1hNHByMVBTRXZu?=
 =?utf-8?B?TDJWdUE5d0JOVGVhdFdkVTRrVW1RNEtia256VlpSQVMxQngwYWduUkoxWERq?=
 =?utf-8?B?SzlQNDBDcWF1N0k5Rk9lK2l3Mm5YMEV1RUs5ajc2RDJ2cUlleFl3Q3U5a0o1?=
 =?utf-8?B?c2pEem9qUmpmbS9oaU9hMkp4aEJzNjNRNDV6TjAxZmp4REZzb3BTRElyQXZX?=
 =?utf-8?Q?8o8YL+yLnhjY02iQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <545C3B3704567543A19C64B7B98D5E66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KI76qpj8GGEfpMkYouYGm+kBp2LtFpaPVB7lmpGZoWbsxXdbrSgLKypKkl/apGwYRnueowDIt3WU7FogwSk+zFhLEn4VqGWOoW7I/DVM4ClQHZIzjsAFELwedTMXy1XzkKCXkPmLA3QUVZPY+lXOD9Sti1zs81o8hdcyHJZObZ6UOGO4zbSDpZVx1d22Yewr05OkKoyWbtbtAnXwNEFNzsfRWECRYcgs9R+GV8OEIKxIFmQeODz/jvnDulm47CQ+qH9iBvXZWx+vS/m77qfsuhPhyIigjIe0YURTBciaVyT7RXyqyRXwdq6EVSbgfdDYfwkd1yAWqWtD6u6Hy+F/sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c29821-1698-47b0-a4bb-08de7dfa3ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 16:38:10.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arLwJek6+DbSD/R5vUIZNaT4O59GJhiC0/Z1Q+wL41b7CCiuZqNyIPDbsPY3oIal6U4cVsZwCiBWzHVGKRygfmvFEWPNWqNr/n7PLUNGTh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 60D7C23D087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDIzOjIyICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IFRE
WCBjYW4gbGVhdmUgdGhlIGNhY2hlIGluIGFuIGluY29oZXJlbnQgc3RhdGUgZm9yIHRoZSBtZW1v
cnkgaXQNCj4gdXNlcy4gRHVyaW5nIGtleGVjIHRoZSBrZXJuZWwgZG9lcyBhIFdCSU5WRCBmb3Ig
ZWFjaCBDUFUgYmVmb3JlDQo+IG1lbW9yeSBnZXRzIHJldXNlZCBpbiB0aGUgc2Vjb25kIGtlcm5l
bC4NCj4gDQo+IFRoZXJlIHdlcmUgdHdvIGNvbnNpZGVyYXRpb25zIGZvciB3aGVyZSB0aGlzIFdC
SU5WRCBzaG91bGQgaGFwcGVuLsKgDQo+IEluIG9yZGVyIHRvIGhhbmRsZSBjYXNlcyB3aGVyZSB0
aGUgY2FjaGUgbWlnaHQgZ2V0IGludG8gYW4gaW5jb2hlcmVudA0KPiBzdGF0ZSB3aGlsZSB0aGUg
a2V4ZWMgaXMgaW4gdGhlIGluaXRpYWwgc3RhZ2VzLCBpdCBpcyBuZWVkZWQgdG8gZG8NCj4gdGhp
cyBsYXRlciBpbiB0aGUga2V4ZWMgcGF0aCwgd2hlbiB0aGUga2V4ZWNpbmcgQ1BVIHN0b3BzIGFs
bCByZW1vdGUNCj4gQ1BVcy7CoCBIb3dldmVyLCB0aGUgbGF0ZXIga2V4ZWMgcHJvY2VzcyBpcyBz
ZW5zaXRpdmUgdG8gZXhpc3RpbmcNCj4gcmFjZXMuwqAgU28gdG8gYXZvaWQgcGVydHVyYmluZyB0
aGF0IG9wZXJhdGlvbiwgaXQgaXMgYmV0dGVyIHRvIGRvIGl0DQo+IGVhcmxpZXIuDQo+IA0KPiBU
aGUgZXhpc3Rpbmcgc29sdXRpb24gaXMgdG8gdHJhY2sgdGhlIG5lZWQgZm9yIHRoZSBrZXhlYyB0
aW1lIFdCSU5WRA0KPiBnZW5lcmljYWxseSAoaS5lLiwgbm90IGp1c3QgZm9yIFREWCkgaW4gYSBw
ZXItY3B1IHZhci7CoCBUaGUgbGF0ZQ0KPiBpbnZvY2F0aW9uIG9ubHkgaGFwcGVucyBpZiB0aGUg
ZWFybGllciBURFggc3BlY2lmaWMgbG9naWMgaW4NCj4gdGR4X2NwdV9mbHVzaF9jYWNoZV9mb3Jf
a2V4ZWMoKSBkaWRu4oCZdCB0YWtlIGNhcmUgb2YgdGhlIHdvcmsuwqAgVGhpcw0KPiBlYXJsaWVy
IFdCSU5WRCBsb2dpYyB3YXMgYnVpbHQgaW50byBLVk3igJlzIGV4aXN0aW5nIHN5c2NvcmUgb3Bz
DQo+IHNodXRkb3duKCkgaGFuZGxlciwgd2hpY2ggaXMgY2FsbGVkIGVhcmxpZXIgaW4gdGhlIGtl
eGVjIHBhdGguDQo+IA0KPiBIb3dldmVyLCB0aGlzIGFjY2lkZW50YWxseSBhZGRlZCBpdCB0byBL
Vk3igJlzIHVubG9hZCBwYXRoIGFzIHdlbGwNCj4gKGFsc28gdGhlICJlcnJvciBwYXRoIiB3aGVu
IGJyaW5naW5nIHVwIFREWCBkdXJpbmcgS1ZNIG1vZHVsZSBsb2FkKSwNCj4gd2hpY2ggdXNlcyB0
aGUgc2FtZSBpbnRlcm5hbCBmdW5jdGlvbnMuwqAgVGhpcyBtYWtlcyBzb21lIHNlbnNlIHRvbywN
Cj4gdGhvdWdoLCBiZWNhdXNlIGlmIEtWTSBpcyBnZXR0aW5nIHVubG9hZGVkLCBURFggY2FjaGUg
YWZmZWN0aW5nDQo+IG9wZXJhdGlvbnMgd2lsbCBsaWtlbHkgY2Vhc2UuwqAgU28gaXQgaXMgYSBn
b29kIHBvaW50IHRvIGRvIHRoZSB3b3JrDQo+IGJlZm9yZSBLVk0gaXMgdW5sb2FkZWQgYW5kIHdv
bid0IGhhdmUgYSBjaGFuY2UgdG8gaGFuZGxlIHRoZSBzaHV0ZG93bg0KPiBvcGVyYXRpb24gaW4g
dGhlIGZ1dHVyZS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgdGhpcyBLVk0gdW5sb2FkIGludm9jYXRp
b24gdHJpZ2dlcnMgYSBsb2NrZGVwIHdhcm5pbmcNCj4gaW4gdGR4X2NwdV9mbHVzaF9jYWNoZV9m
b3Jfa2V4ZWMoKS7CoCBTaW5jZQ0KPiB0ZHhfY3B1X2ZsdXNoX2NhY2hlX2Zvcl9rZXhlYygpIGlz
IGRvaW5nIFdCSU5WRCBvbiBhIHNwZWNpZmljIENQVSwgaXQNCj4gaGFzIGFuIGFzc2VydCBmb3Ig
cHJlZW1wdGlvbiBiZWluZyBkaXNhYmxlZC7CoCBUaGlzIHdvcmtzIGZpbmUgZm9yIHRoZQ0KPiBr
ZXhlYyB0aW1lIGludm9jYXRpb24sIGJ1dCB0aGUgS1ZNIHVubG9hZCBwYXRoIGNhbGxzIHRoaXMg
YXMgcGFydCBvZg0KPiBhIENQVUhQIGNhbGxiYWNrIGZvciB3aGljaCwgZGVzcGl0ZSBhbHdheXMg
ZXhlY3V0aW5nIG9uIHRoZSB0YXJnZXQNCj4gQ1BVLCBwcmVlbXB0aW9uIGlzIG5vdCBkaXNhYmxl
ZC4NCj4gDQo+IEl0IG1pZ2h0IGJlIGJldHRlciB0byBhZGQgdGhlIGVhcmxpZXIgaW52b2NhdGlv
biBsb2dpYyB0byBhIGRlZGljYXRlZA0KPiBhcmNoL3g4NiBURFggc3lzY29yZSBzaHV0ZG93bigp
IGhhbmRsZXIsIGJ1dCB0byBtYWtlIHRoZSBmaXggbW9yZQ0KPiBiYWNrcG9ydCBmcmllbmRseSBq
dXN0IGFkanVzdCB0aGUgbG9ja2RlcCBhc3NlcnQgaW4gdGhlDQo+IHRkeF9jcHVfZmx1c2hfY2Fj
aGVfZm9yX2tleGVjKCkuDQo+IA0KPiBUaGUgcmVhbCByZXF1aXJlbWVudCBpcyB0ZHhfY3B1X2Zs
dXNoX2NhY2hlX2Zvcl9rZXhlYygpIG11c3QgYmUgZG9uZQ0KPiBvbiB0aGUgc2FtZSBDUFUuwqAg
SXQncyBPSyB0aGF0IGl0IGNhbiBiZSBwcmVlbXB0ZWQgaW4gdGhlIG1pZGRsZSBhcw0KPiBsb25n
IGFzIGl0IHdvbid0IGJlIHJlc2NoZWR1bGVkIHRvIGFub3RoZXIgQ1BVLg0KPiANCj4gUmVtb3Zl
IHRoZSB0b28gc3Ryb25nIGxvY2tkZXBfYXNzZXJ0X3ByZWVtcHRpb25fZGlzYWJsZWQoKSwgYW5k
DQo+IGNoYW5nZSB0aGlzX2NwdV97cmVhZHx3cml0ZX0oKSB0byBfX3RoaXNfY3B1X3tyZWFkfHdy
aXRlfSgpIHdoaWNoDQo+IHByb3ZpZGUgdGhlIG1vcmUgcHJvcGVyIGNoZWNrICh3aGVuIENPTkZJ
R19ERUJVR19QUkVFTVBUIGlzIHRydWUpLA0KPiB3aGljaCBjaGVja3MgYWxsIGNvbmRpdGlvbnMg
dGhhdCB0aGUgY29udGV4dCBjYW5ub3QgYmUgbW92ZWQgdG8NCj4gYW5vdGhlciBDUFUgdG8gcnVu
IGluIHRoZSBtaWRkbGUuDQo+IA0KPiBGaXhlczogNjEyMjFkMDdlODE1ICgiS1ZNL1REWDogRXhw
bGljaXRseSBkbyBXQklOVkQgd2hlbiBubyBtb3JlIFREWA0KPiBTRUFNQ0FMTHMiKQ0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNo
YWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEthaSBIdWFuZyA8a2FpLmh1
YW5nQGludGVsLmNvbT4NCj4gVGVzdGVkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1h
QGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCg0KQnV0IHRoaXMgaXNzdWUgaXMgYWxzbyBzb2x2ZWQgYnk6DQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyNjAzMDcwMTAzNTguODE5NjQ1LTMtcmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20vDQoNCkkgZ3Vlc3MgdGhhdCB0aGVzZSBjaGFuZ2VzIGFyZSBjb3Jy
ZWN0IGluIGVpdGhlciBjYXNlLiBUaGVyZSBpcyBubyBuZWVkDQpmb3IgdGhlIHN0cmljdGVyIGFz
c2VydHMuIEJ1dCBkZXBlbmRpbmcgb24gdGhlIG9yZGVyIHRoZSBsb2cgd291bGQgYmUNCmNvbmZ1
c2luZyBpbiB0aGUgaGlzdG9yeSB3aGVuIGl0IHRhbGtzIGFib3V0IGxvY2tkZXAgd2FybmluZ3Mu
IFNvIHdlJ2xsDQpoYXZlIHRvIGtlZXAgYW4gZXllIG9uIHRoaW5ncy4gSWYgdGhpcyBnb2VzIGZp
cnN0LCB0aGVuIGl0J3MgZmluZS4NCg0KWW91IGtub3csIGl0IG1pZ2h0IGhhdmUgaGVscGVkIHRv
IGluY2x1ZGUgdGhlIHNwbGF0IGlmIHlvdSBlbmQgdXAgd2l0aA0KYSB2Mi4NCg==

