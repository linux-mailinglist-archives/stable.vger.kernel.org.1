Return-Path: <stable+bounces-192552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8BC3865E
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 00:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D233B3CD5
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9B212568;
	Wed,  5 Nov 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4nbjqtz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BF2EACEF;
	Wed,  5 Nov 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386429; cv=fail; b=enOEKDfuXvCdX1ZyUdnHNb2PiD384L6qIcCuSWS0Qi2adMjKBEBpGrhOWHwVbDWueHurKXadGaXs8wEOfMPgEHHR5lwTnyEq7rNLoRjmP+l+1e+8LLYKGvZc6/XuaqPEOzmBHwnwi/sqSwNArWngxaZa70bSStI+TKrWTCubR+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386429; c=relaxed/simple;
	bh=JascdRozRA1DsJRCJhk7llB6JSk+65B4dOH10+wuHJ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBLLG6ytbdzYbWxPcgf29bVNOP7VfpivSdQUiWZx7QBRPUKu8cO8d57Vk0ksgSakhyjWiDwVy7BRGKFr1kUgr5OIr7e486sMwiujLK9Ji6vrcIrzdb7nTCpSVZi/BQAjT7uC96QyWbbHFDDBfD67PpzUSo7QbOQ0P1K/74P40Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4nbjqtz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762386427; x=1793922427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=JascdRozRA1DsJRCJhk7llB6JSk+65B4dOH10+wuHJ8=;
  b=Z4nbjqtz3bZX6Pyg1/UIIJEQIMnwKyrr3giG9y2hQ0P/quT4FHhnbyQV
   j3wwrsyme1tTTFp4uI3sPOKHj0cgPPmYvtsz8PehWekn2QObLy13MofC8
   nrFG1/2NaAzXKyrW3kb3cR8bBJMuCT5pnWPu5w/zImGqV78o2ndbJzwP/
   MOSx4X+7K5959l9/ngkRc5KuE7Kbs0nJgDTmhtGrfihWPQ37L2QrQnkVN
   ec+15Bj3R6Cs4OX/VMuviKIt6SPXQCNy6ccRXffldgSUn/lRpmOsIkrGe
   P29dsovWxfhYxajoTu2daKXObAZ/eszNHgdN48R1kspW/tsgEkTtrncTF
   Q==;
X-CSE-ConnectionGUID: jokH7iiSRTexsPZ3qWOSEw==
X-CSE-MsgGUID: fJ1nxljRRvm4k0fPTkWRwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64211892"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="64211892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:47:04 -0800
X-CSE-ConnectionGUID: /XfY2wnQTEOSPrUZ44508A==
X-CSE-MsgGUID: gQs0oK1QR0q59Ft2p7J/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="211067957"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:47:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:47:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 15:47:03 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcKth8okvZrpM7/NoI436G3U5c8UYHO3HgsCf83gePX7HOWOwKc3Fu93U7LxAN1MHgpV6GShnESPh8p9UJGdTIozQz3KWnylN7b+SDgEWOFrFOCuRim870tVzDdgBP7nqV9M/tJcLpAVTpdfftWvh8GZuDqiwB4Ymqzo+7zyMgoW5SH6jrGvVdAL/XRo/A15Q3eNpybAQotI9cc5ywf+iSXAama92GIrYuuEuSnvKDZ+caKKu/KijHQJQYsP6mW9r9ixTgViH06sz5KoA58gNqGWkf5qhv91SagD6UgEh+BB/UDpK72tcwHIUhi6NTFiODl3lZyWWmk0PkLqb3VXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JascdRozRA1DsJRCJhk7llB6JSk+65B4dOH10+wuHJ8=;
 b=Fk7XRnXRa2xt5eBDzCUvedf72QpPtgv8TmjSrBtHx+OG6Up7pEXgf6RdZDDyZAnajxOw7AfU+AXB8hnqJOmRkUap0YMmQkJel/R9tXb7Nu0HkJhgZLUkL+Z4IpZ8iOKa69FO97JwWfQYcFkVOqtq9tWAxnfYts8AU5QeKxbudxUiGv53fjUkbHZNgD3B/zlXD83uk1mEVSxNr3mOyvCUoPi8lPmBGprKSMSNgnUz0Sdhr0rXmgErBxAzQyZPEWzLOdZU+ZXnpTW3g5vPhzqZH1AC4KpnWYiWHAlZMg7067fwum+pl/e45ELewGKiAqKufsyo2IPoV7MmnL21dW3V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.9; Wed, 5 Nov 2025 23:47:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 23:47:02 +0000
Message-ID: <f1f2c082-0597-4130-91d2-2059df3ba72f@intel.com>
Date: Wed, 5 Nov 2025 15:47:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@treblig.org>, <mrpre@163.com>,
	<nate.karstens@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stable@vger.kernel.org>, <tom@quantonium.net>
References: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
 <20251105231212.1491817-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105231212.1491817-1-nate.karstens@garmin.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------EVvyN0Zaa8ZnFf1PfDx3S9vs"
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7240ca7e-8b24-4172-9fc3-08de1cc59e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWlEVWpIWW9adU1RZ0xpNmNDUndlUys0Tk1HcGtaTGdPYWtsWDI4TDRQeVho?=
 =?utf-8?B?RWQxV2NiSDA2UFgyQTR0N0djMHM2V1VjQnNrVFU4NE5iR0loZ3VBbmQvU0cz?=
 =?utf-8?B?YWdMSkpEcWJlZ1ltaDB3eXVnYy8vMDc2MERIZUM4T2loWmVHSUZtVEFuMThs?=
 =?utf-8?B?SmtrTGh3NzIzakdOcVIvMkwzYk43Tnh0WEU4ajVJTUQ1SVpVWlhVdjlMbStS?=
 =?utf-8?B?UDJSQlNrTnp2Yk1SeDZ6dE1wMExRWkFTTXBRdjVtRkR0NkZsMjY3VHBJZ1I4?=
 =?utf-8?B?THdkeFM5bTZMQnNidXhJSHZLQWp4L2dXdjdmdkZsRHZVQ2x5MThpR05hbkpB?=
 =?utf-8?B?V0JjMzNONEdnQjdtREk1eFpBaUx4ZGxXOHRJb3hoN3pvVklWUnFkVDVjSkxx?=
 =?utf-8?B?OXIzMGM1NjNsTW1hQnpmUnZBa25yMlVrWjBsVHdidXFGRkV3QysxbXl2TXhM?=
 =?utf-8?B?WnhVMzJMeTdQU2JRVy9nemdId05OVnVqeGhTMk5EbHJtNmJSUE9ReFI2Yi9G?=
 =?utf-8?B?WkRrTjZpbmJNd0xwd1RjSVBMa05wbEpHMmxWN3R6L09hRFB6bHZ5WkdiZVhG?=
 =?utf-8?B?MjcyeGRIUzRHb1dOcDEvMTlYT3FNSkpoSGgzYnZQemd5UW8wNElJQ0UwcFpk?=
 =?utf-8?B?R0hUdzNPb2NJNkhHTStsWjdqQm9vRDA0WGNaYVFtUlVneUJXbWc5S1NuWklG?=
 =?utf-8?B?dGMreTFFSERxRmx1MGh0NkNHUE93UWFDcnFvZ284dVNuZlNYRlQ2QnlmWWxT?=
 =?utf-8?B?bEZUNUVYa3Z5czRuU3N2aVduRFZSeVdtSUNVTzRJeHl2NUM5MFhVNDFpR1N3?=
 =?utf-8?B?RXFMUnpXWW43d1hETHQ2WDdNRERrMWNTOWxqK1M5Y1I2OWZRVTd3VitUajdw?=
 =?utf-8?B?YU1jN3BZa0VRUFhzUHI5Z1gvaDZ4bzZwaXJ1ZWx1Y0Fuem8rN1dubXhBMnhm?=
 =?utf-8?B?Sk93YjgzWjlRVjFPSS9KN0N2ZE5taG9wcHQ2Y292OXR5dE1wOVdNU2dXMmpJ?=
 =?utf-8?B?V0FpTFRzUm9LY1hyd2FiNjFZc1dYVHk4Zk83VWRxRHN5L2xUSzNkZzRqYzRM?=
 =?utf-8?B?MlJTMkxuVHpFbm9ZUnkwUjFjMEs1M0hBVkI5N2gxNnZHRDlMcjZMQlFDWk1J?=
 =?utf-8?B?bk9JVGlBcTlJSWFHeWZjc3hoS01pV1pXQXZXZXVNTzJyVTRPSXpDR0w1TDN3?=
 =?utf-8?B?MzUwelJDbUpyYXpvOFpFcGt3cmJJSGpNYlBoY2cvaUwvTUtVMkFHQVVPaWlV?=
 =?utf-8?B?NENtWXBCNm9iT0FUK1AyNGc5VVRBdEVXNkpGOURPd2hSZEp4MGsxanllWDhi?=
 =?utf-8?B?aGRQQmo3a0huY3VEUUxFeUtQa0EwcDhSYU1VcGtHVUtlc2dvREpJWk1EeEVw?=
 =?utf-8?B?dGwwUjltQnRSRFN1VWtkcURkNmRSR0R2eFhGeEFnbE1FMmtZclc3NWplOUda?=
 =?utf-8?B?bFVTSGxmRVBkejJqNk5mdmwzQ2JRVXRWU1djNTdYNmhrb05xc3c1THV5eHVL?=
 =?utf-8?B?UVkrRC96TFp5cWxkdW8rU3EvdWs3US80SEVtSWwxL3lyMkN6VkUwdWQyVzVB?=
 =?utf-8?B?VWFtM1FiWTdYbExSaXRLQkpKdlpGUnYxVlVUa3VBeklQSy82M3UrWElEQzh2?=
 =?utf-8?B?L1BQay9XL1RUSEJzcmlqbFdXSloydmV4Ni92MDNJNmNHTXFpUkd6L1BsQXNG?=
 =?utf-8?B?M3FLQjZhVlEreUtJOXNSUWdaVnpUcERYazJMTmY5ZW5DRExIZ0I4dGlsbE1O?=
 =?utf-8?B?MFc1RGU5akthbjN0UHhRMFN4cVN6TEZoRE9sOXVYSFR4RFQxeHdtS0w2aDlS?=
 =?utf-8?B?L1pXeWVhaWZseUYydjNDdTArUVVzYjRwZTNzWVI2NW5INk9FU2VIUlVYeExB?=
 =?utf-8?B?Q1BRd2VER0s0U1NxcmE4OW9vMGZ3cmFlWnVZcXh5WmFVWlNBc0hUbUkxdXVs?=
 =?utf-8?Q?5CfusiKJYzZxQ4kim7qV32RgX0aC1/nf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlza3BsU3QxWDAyUENYV1paVE5oV2hjM0xLZGVVQlNmeGdhOFhZa21WeHhD?=
 =?utf-8?B?MmtlK3g3SG51aVlyNU9FSUR1aWEwd0tSSWdPOE9ycGYwaVN4ZElBZ240WHN6?=
 =?utf-8?B?SGdNdVFaYlM0MVdhejhaYXJYSVk2SElOQmFUMFBrdjBjL3NVb3ltMS9UaW1u?=
 =?utf-8?B?cjMxalN1SnFlNXQyaURGTU1WcHh5cnNTY2l6bVdVQUx2Snd6K1VlOUlrK2xj?=
 =?utf-8?B?Z2kyd2laZENXTkRNWVNFRlNpcmRseHFIWEpWV3FIaHdZUll5aURadk91NEZM?=
 =?utf-8?B?ZXBLcWdRbS9uOHhUWk53RWphVjF0WldtUGtxbEpCNDNCQldRTGhRL2VEdEVI?=
 =?utf-8?B?RjV4UmlxWmxUdmVleGExTFNLOUcrK3NMNVVMMUV2LzQrNXJPVStjc21YZjVU?=
 =?utf-8?B?clVES3VZWnBhK0NkUW90Q2pHS2NIcUI4UVFGU3NkV3RnNXJaV0dpVkR5ZjhW?=
 =?utf-8?B?ZTRWY2lIZ0Vjb1FiNjd2dWR4Y1F2UFdndDBySUhWbHZaVkEwaUNnRUtVUHpu?=
 =?utf-8?B?Umh5VGxPV1hIRjgrUmR2WFdjV2h6eWF3NThNcmVUdjR1TzZoVkxYdzVCS2VG?=
 =?utf-8?B?aXoraVdoZTVKTTgvYnJrS1RiUEp5amJidGdaT2pZY2dCWmxiTDdwNERCamhP?=
 =?utf-8?B?MXN5eVAybTgyM1lKYTFWZXplYmZmWUNveDB6bkFDaFRESUk4RGhZcXZxQUxm?=
 =?utf-8?B?VGRsSCtXNHozSHZaSktISjZuQkE5cnI5Vkw4dlpZMXArVXBRMTVWbXRUaWRt?=
 =?utf-8?B?aDZSQldsd05IbmxreUJyV3dJWmZ4Wk9IMnVaaUVaZjRlNTFaendQbXQ0WDJO?=
 =?utf-8?B?d0NFQUYrdCtvdXNyUXMvcmhwNFpyeGZDd2VhTVZSOGlEOTA4U2c4NEx3Y3ps?=
 =?utf-8?B?RDlsWmxWTmMxRzBXd2UwVFZkdTZqYnNFM1o0d1hyYTBIcnZnYnloUHZGUk5Q?=
 =?utf-8?B?TGJxc1ZXVC9VQjhUck1Sb1FCRWg4Wm5xdXJweXZzbGR6ei9neFFLTHdiUHR5?=
 =?utf-8?B?S01ieFFLSjNOZitmWFpPdWtzZEczTzMyVnk3bTNoMmwwc0ZLK3YwRFBkQTBY?=
 =?utf-8?B?ZEs1VGdnRjJLcGQwZEpWNmM4Q29nWG9ObUNyWThUL05yZEZTNnBkTmI2VWhG?=
 =?utf-8?B?Y2xnZCs3dncveHJEZDJPNVAwQmcrN0ZoVndVNG5zRlJMbks1MnVPdTdOUlgv?=
 =?utf-8?B?S1J3eURXbmRPWkJhcjE5V045RE9kaDRVVG1VY0JVNFovSHhRSllKRHZBa1RM?=
 =?utf-8?B?VTU0SGlPSEhVSFNzNXo5MEVDTGsvZWdpSlNmWERzQ2NkNGpFVEFaUUZYbzI4?=
 =?utf-8?B?OUFFTCs5MkN3WVVodzFhb0lTcDFCSU5uNWQxR3d6UDFINytxa3Fydy81R3c0?=
 =?utf-8?B?K2pEL2xteW9TR2J0Q1dZOEZMUW85OCtoamFEWVR0dUIwV1JCc01xUUVUSEsx?=
 =?utf-8?B?S0U2MU9WSjBFTklRWkp4VkJJRGFnYlVEd05ZVW9LMnRLVDdQVDlOb2tyS29V?=
 =?utf-8?B?MTlxSnFtbS8wVW8zSEN1L2tQcnNwY0tYSFkxMGd1RE9YcXkyMndnR1Q2TVR6?=
 =?utf-8?B?cFdqY0EyREttaXUveC9JSlBKSkw3ZG5FOG9CdUh0cEJrRHFHK21HczFwcS9N?=
 =?utf-8?B?RWU4MWJ6RFdFekxKNHJXaEkvbWJMNVhCOUZxd0NyTStUTFpVRnlzVDVPUXAz?=
 =?utf-8?B?Zm9MMm9TV3A0ZzBMbDZSQnBSbnZnUVExaERzODFia3BURVdtb1gvR2JjNXI0?=
 =?utf-8?B?djB2WC9vSkVzQWNVMHBVZlFZR2d2L0RCdk9oUHVtK1ZoRHZsSGlMTEl2N2w4?=
 =?utf-8?B?L05uSUhMWEwvWFNQTWM5TndaU3A4OWd4M1F5ek1SUko5OGR1Qk5IWWhnQ3lT?=
 =?utf-8?B?Wnk4QzZpWU52R0dva0tVdFdXdG5Fd3lKRXQ0enpsL3NNR0dxb2t4akF1Ylhu?=
 =?utf-8?B?NGF0Njl3c1ByV2dTajNFUTl3MFBWSUd2ZjRVL1UwK0V1c2c2S2pTS25BWjM0?=
 =?utf-8?B?M1c3YmswTXh4RzcwZ0MyYVNQQklvdFZaMUdBQmdtRXZubnh0SXJGSFgrbWEv?=
 =?utf-8?B?Y1JXMUZnRzlGRS9JQXZVTjVqUlBlbUd5Z2I5a0NWUXJsdUc3UlIzRjdoYmFU?=
 =?utf-8?B?WUdEM05TSGFpTnQ4MnZvN0Rpc1owak9rdnBhV21GVUY5bzB6cDZSbk0zR1ky?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7240ca7e-8b24-4172-9fc3-08de1cc59e0f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 23:47:02.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HuNVupuqwP1Cxbb7ehVLFMjdKXHppeOqXmkMUYpHw2+mhEi2PO5U7hT7UZ6P8bkT+CuOoZbb2biXhAHY8r95LWKhuMbTBpa6wuKoxo3qFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com

--------------EVvyN0Zaa8ZnFf1PfDx3S9vs
Content-Type: multipart/mixed; boundary="------------fiZkJDy0V0AhR3lI6G0I9FwV";
 protected-headers="v1"
Message-ID: <f1f2c082-0597-4130-91d2-2059df3ba72f@intel.com>
Date: Wed, 5 Nov 2025 15:47:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@treblig.org, mrpre@163.com, nate.karstens@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 tom@quantonium.net
References: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
 <20251105231212.1491817-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105231212.1491817-1-nate.karstens@garmin.com>

--------------fiZkJDy0V0AhR3lI6G0I9FwV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/5/2025 3:12 PM, Nate Karstens wrote:
> Thanks, Jake!
>=20
>> So, without the ssize_t, I guess everything switches back to unsigned
>> here when subtracting skb->len..
>=20
> That's right. In C, if there is a mix of signed an unsigned, then signe=
d are converted to unsigned and unsigned arithmetic is used.
>=20
>> I don't quite recall the signed vs unsigned rules for this. Is
>> stm.strp.offset also unsigned? which means that after head->len -
>> skb->len resolves to unsigned 0 then we underflow?
>=20
> Here is a summary of the types for the variables involved:
>=20
> len =3D> ssize_t (signed)
> (ssize_t)head->len =3D> unsigned int cast to ssize_t
> skb->len =3D> unsigned int, causes the whole comparison to use unsigned=
 arithmetic
> stm->strp.offset =3D> int (see struct strp_msg)
>=20

Ah, right so if we don't cast skb->len then the entire thing uses
unsigned arithmetic which results in the bad outcome for certain values
of input.

Casting would fix this. Another alternative would be to re-write the
checks so that they don't fail when using unsigned arithmetic.

Given that we already cast one to ssize_t, it does seem reasonable to
just add the other cast as your patch did.
>> If we don't actually use the strparser code anywhere then it could be
>> dropped
>=20
> It is still used elsewhere, and ktls still uses some of the data struct=
ures.
>=20

Right. Fixing it makes the most sense, so that other users don't
accidentally behave unexpectedly.

> Cheers,
>=20
> Nate

--------------fiZkJDy0V0AhR3lI6G0I9FwV--

--------------EVvyN0Zaa8ZnFf1PfDx3S9vs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQvh9AUDAAAAAAAKCRBqll0+bw8o6GYo
AQC9F5vBMoCaKgnoRTAmo8wth+gKxszniRk+iOCsGXV92AD5AfU6egyWgbuBdg6ZP7yYihvkpSoM
AKAGfhTf3PIsDAs=
=gUDa
-----END PGP SIGNATURE-----

--------------EVvyN0Zaa8ZnFf1PfDx3S9vs--

