Return-Path: <stable+bounces-114205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782AA2BC0B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 08:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C359A161C5E
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCE194A6B;
	Fri,  7 Feb 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqbI92Wp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25638385;
	Fri,  7 Feb 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912066; cv=fail; b=o0RTgjvHAzG4nifydKv/RJvalPw7JqCP051lfde1Tpa7mr0X1tMLJ1gYzrQUmDclBmFO30rFr9zlLUVg61J+N3FuX91fJ9z+3dxISV255/6BADPZmcdc3H32eP1XxTYl1JaJ0cT302f1OodQEW952Eeu7GKgZLSat/U4yFA5dns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912066; c=relaxed/simple;
	bh=QHerQgFFOgEkZvAartQTdXFPj9B2WrOZmGUxJmV8dEE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RFdVy6b5fXWFX1ESZcAxlaMD+PZioI2Rr7fCwMHfLTcCsraQQ557vqhi5LTVrOiFueIVdO7lG83pQnh0YQ9DG9aMkEHv2uHm94rMiVsZVQUCc82zgs1Oqg4GatAKjTU864n/fLZ421v5Q3nj1Dtzl+A3u2H78T/ZqnJFjdSHLfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqbI92Wp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738912064; x=1770448064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QHerQgFFOgEkZvAartQTdXFPj9B2WrOZmGUxJmV8dEE=;
  b=PqbI92WpGMbTT1u0nbiHFtFmtE+X2yD+CbqyMBqKw80dwqhTsSYReHeu
   s/6p6Buq6cHhOxvFpqM7oFvsd76Wa54J6qJOtJxma99DBhD3GcDIrLVdk
   LTErQFpsfKIuzFSQr0EyjuAKyAZtJM30sMr67nf1ufkoqWiTZQ4ftiBUv
   kL9HdzcFEv5ixMxHAbD0qfyWorsiYdBe7vw8OsLbXa5GPhNIpGAgUj/ws
   B0dv8iEdxV4IDqHhYsMEDU+yWaCZMeOCMBUQK4W1Ww9Z2tZK394aRzrud
   coY8Q92lXjaa/1FS1Oxk950M7FkGpMR65OxxBCFqgJVFVKJhae9S7cUjk
   g==;
X-CSE-ConnectionGUID: aSGCwMeSS5SL7lfSX2C62A==
X-CSE-MsgGUID: vOF6RJiORJGC0xFMURg4Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="27152834"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="27152834"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 23:07:43 -0800
X-CSE-ConnectionGUID: 9b9a8wRSSA+3MmKZwWj+UQ==
X-CSE-MsgGUID: +HRJv7TJSA+xL6CJ/tN3Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116387413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 23:07:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 23:07:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 23:07:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 23:07:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtVNxTUTjGAaBXS1wbCoZmvkpJeCgUbzcFCDc47vG8CYHewi0bJmlP//Df7dA5n8B0gKu2CM2gRpisuNM7ziSzK+u5Shvn7IB3knrXrQRnx1hYSJglF1S/1Tp4uEHSbhxx5a1F77ukmmSKesJ/ignpJ+sCLfA/x/CXO94F4EibJ9hpxk4NnG4cYEVFIoRA1icllgoejxhm+E+OfUiIOByU1lTFn5JR8z9AR7N2GGnaTX7FkqLe0Ld3hpGoHzzhud9fEvfdMrFijk9YbeNABqEZQp0+bsjTkhquDyHiChmS85iuE51qbe5ANWYUYwt+55gXpGHYre9vjaaiQFuB4HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J5/7caW6to27atwmAL9PDZX5m3WzOX3P3KVWQAvTY0=;
 b=NDcklatAufqs5fLc8JfOXM0qR41+wGH50tVFFWwly7T0yl4KsMSRQYPqEmHbb3mJ01wGT5UwNOctJ7xMDqFWONM/9wPdfI4ptbGOaICocMAsVMIMm0dYhq6NQigTP382ow5XsZC+h/4cP2ruiCRENl6YRKgB4THiPExWiqD0THfoXUZ41T729SYtMroDWCFHRh6aI0sv9iii8GZG8zeda9bD+ALfTwp8qkKyYJx9aK7fpm82oNN1CjomFrJ8ahbL2qstLqX/CPFe00WRi6JwB8D551q3jX3uHZBGCpskyv4ieTt4ylatpkeEnTIv+v+qZ3WCed1ox1QKknSOEBFkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 07:07:13 +0000
Received: from SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::e7f4:5855:88a5:496c]) by SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::e7f4:5855:88a5:496c%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 07:07:13 +0000
Message-ID: <bee6e7db-80ec-4150-900e-e3d42938ceed@intel.com>
Date: Fri, 7 Feb 2025 08:07:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ptp: vmclock: Set driver data before its
 usage
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"David Woodhouse" <dwmw2@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
CC: David Woodhouse <dwmw@amazon.co.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
 <20250206-vmclock-probe-v1-1-17a3ea07be34@linutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250206-vmclock-probe-v1-1-17a3ea07be34@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0032.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::21) To SN7PR11MB6678.namprd11.prod.outlook.com
 (2603:10b6:806:26a::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB6678:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8c3f5b-1351-433e-b25c-08dd47460bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck9HRGhkVnkwMEwyd1ZlMFNFcG9odXRkZ2VMUkswT0dWS3hPOXFUYmRnNHN6?=
 =?utf-8?B?bGdEZ1UwWFpsTFFUL1kyRHVEMmFWeDZaelkrWEw5akpvVUtWM1JoeHJkNE1L?=
 =?utf-8?B?MGl2TjMzWExFSzd5TWZ6OXRJQm5ZMVdCaDJZTGE1WTVlSHphSHJEK3dZek9T?=
 =?utf-8?B?RG15cEhyL3ZhTmprd0RqKytmT3ByOWpZTER1ZWdMdi94NFd1d2VGaGd5MXVV?=
 =?utf-8?B?SzVZVmwzTHppcnJRNlc0YnpzZ053eFBEalBEVC9CYkptZmhIcDc1RTl6b1Zj?=
 =?utf-8?B?bytBVkdZZWgxN2loa3g0Y2dmeFR5UDlIOTZ1Y2kzVE56b2l6ZGNvcFFaV2pX?=
 =?utf-8?B?eHdxRnlzVVpDS2dTd0F0dUxBamkybExRN0QrK0tZTXdZRUpiUnpSQWZoRWZR?=
 =?utf-8?B?U3BzaWU2L1RaSnF5YlRFaFlWTllnQzNLR1dzZFJ6M2NWaHdncUEzaGdGWjFI?=
 =?utf-8?B?UG5pMEtwZGlVVlNMWS9BZTQ2ZzdkbG9yejhYZjhHRGtNNHFhUitqNjJuM0Z3?=
 =?utf-8?B?VGVNbVFMNVJDWGptamVQZHdwKy83c1hkd2Q0REFteE50bU9Hc0JvZHdOYWhk?=
 =?utf-8?B?YlZUdWZRSUkzQVNHdGU0MG41K2VwN3Y4SkMyY1VxS0xHd0syYmdkaU92cFdU?=
 =?utf-8?B?aXc2ckZHV3ZFMWIvQ3AxVGxwRGlyTVdjcEN6TWNHcktOdHJobTVQQ1RwYzdY?=
 =?utf-8?B?WXdyTDZsYVVXQXJJb3V5Vm9nTFY3ZThOM0RyMkk1d3pPcGdWTElqYXF2Z3ho?=
 =?utf-8?B?aHRuQnd4V1NUMEtjODBVc0xTRCtjZS9qaTQzWEdJR0NsdFFVM3hSbE1vUGxM?=
 =?utf-8?B?cENOd1pvUE9TbGFyTUVYNFVHcmVMd2dEQS9tOWcrTUNzRk93Nm1SdTh3cHhn?=
 =?utf-8?B?QlRWd3FlTFAzOU9odFh2dm9wMjNaMVB5U1hSQ2ZkQ0NoVUVsaVJnbC85L3Jn?=
 =?utf-8?B?c1VxQ0xiVDNYOFU1eVRxcUdaTEtjTGxiTUgwSVB5UXNzYXNFSXp1c3J2bUpY?=
 =?utf-8?B?K01HYTcvd3JzTmlJUXBUTWx4eGhKQk9lUW1OaHR0UDg1SVN5TlNUTStNdU9j?=
 =?utf-8?B?c0FPRkx5OFdyU2NWaUM4Q0I4MWdJdEZaYmltcTdNdTVMY2NsRW8ydHZnV2N6?=
 =?utf-8?B?aUpkeEtQL0xuTU45cloxTG1DMHVnb1VqTVhtQm05Nm1xbk10T2VxM3g0Ymtv?=
 =?utf-8?B?SXQzZGFheXd2cC9LRTFoQnlFc1hIbUtjOTVTZUgyMGFuS1VsSTYwdnArbWdZ?=
 =?utf-8?B?RUF5S2RjWVRONmFzSDFneUcwaUFWNDMxUW9TbjMxK09SNDJwcGhDU0o3MGZ6?=
 =?utf-8?B?cWJrZDU3Z01yNU9oWW1ONEFDZWplTDVsQkREMHdsNUZWMXE2ZjJDbHc1OFlC?=
 =?utf-8?B?aHhaMi9KZFpoQ0twbmNnWmI0VlpoQXhGMENQSnI4aDNzSUJ0cjk1UXpIUnJR?=
 =?utf-8?B?N2g1NkdSNFVrMjFoZmEyc01mM3BmVk4rRzJPYXNmQkp2clRGMHlLazBnaGJC?=
 =?utf-8?B?cXhvVVBGc2ZvNDBRellmcjRoQ0J5YTl1Tzh4UVJPZEVFdGlkcG12UUNZSWZl?=
 =?utf-8?B?bWxETG5kT3Y5QW1hT3V6RisyUVNzZW00OHRsOUZmeEpHSkQ1bXA5VXYwNndw?=
 =?utf-8?B?eFplSGgzNzVIVDJYSmZKeW5VVjNCSlNOMk1ncFpQMmR2VUVPK2tGS1VKUHQ0?=
 =?utf-8?B?dEpiRzJYcjJLb2VyVGZjeHBnZFhKbDJQSEZZSmFObkN2Mzc5MW11MmdHN3NO?=
 =?utf-8?B?ZXdDajc1K3BOVVlTODkvSjdERko4dnVrem5pejgxUUxOcUI3aHljVkxhbTUz?=
 =?utf-8?B?Y3FramdvL05pU1c1dW0zbW1VVFZXVXhucHRDbkM2c2ttckVRQTBjOU5LeEJ5?=
 =?utf-8?Q?Mf5x2IaWnM1xp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHozZmZHaGg4a1ViWlEySEtOWlJOTjRRRG1sbXlKSzZZL2QvKytWUU1mQkZF?=
 =?utf-8?B?VEx1WmVlek9zTi9PMlRKUFNCRUtWd2dOK3pwa01YaWUyWXB2RVZKNW9CU29S?=
 =?utf-8?B?Q2RHS0lPN3doUG9BVTJ6eHpKbWxkS3dmUmpPWmg0Z0kxOFJ0UnpVWmtmcGJn?=
 =?utf-8?B?T0d4K3N0OUUvVWpDWDhFMnMyM3FnWm4wamlRejVVTFdjblhkMXJIT1BwaCtW?=
 =?utf-8?B?T2tEaGJEL0l5c0lTNWU3V2dBcHFPakROQ3dic0t3blYzMkZUV09ud091V3E3?=
 =?utf-8?B?dnB4MFJZaVRmMy9qdU5najBDWFpJTGdTU2J1dkM5R29QRlBhNE5FdHdjUktq?=
 =?utf-8?B?N3ZmZVUrSk1YMlEvOXFOdGsvSmFBSnpwRS9aRDdwWUJNQXowTjN4SDdJZWl1?=
 =?utf-8?B?TXZldmZPV3JaTHBJSVJoUDhDSUJzS1JDZHZ4bFNCMVBlUDE0b3dHblJWcXor?=
 =?utf-8?B?eGlCV2x4b3ZydStWQjJ4Vlg0OHFUNDkvWng1Q2J2citxSisxSUFUQ0QydEZ3?=
 =?utf-8?B?UlVJdklzVzg2OGcrTitmaHhlQ3dOeVV4Y0U3ZU9heC9wcmNhVzdTTGRQenFY?=
 =?utf-8?B?S0gvYTVKVWNUVjRvSzcvejVQUmU3OFc4LzJRbW9YbXdyTHAydFI0dGN4UWxM?=
 =?utf-8?B?RHEwYUNYa2VpVjVHOVdNdFpBSjZqWTVGdVdlS1RuRnlEQ3ZIc3FTaDlxQ3BG?=
 =?utf-8?B?OHlzSzN0UkhNZDRGMElhUkE2OVhkcU1melltdGdXRkUvWjdvSlMzdUIreUFz?=
 =?utf-8?B?UCt2MWtsOEUxdUk4WWFleWIwYlFwTjdKM0xSVk5TaSsrNFRzYlFKSENMS2R4?=
 =?utf-8?B?ZkdDZER0WUNqVlBROXd0aGpXWVZ2N2Q1ckVCaW9pUTZSb0FrY0lpZHoyQ3pZ?=
 =?utf-8?B?TUxGdzRHaFVVVms5RHg0eXc1OGh3azNsd2VxaFNHYnloWDZrOUgvK281bjFZ?=
 =?utf-8?B?L05JUlpkZ1crT21XK3VhQTRobmkzWmpnTmE1aUZ4VXVhWTlhSlVQclN5cGNo?=
 =?utf-8?B?SWN2TzRyK1k2ZkxJa0QzQzBwcHpmdjNDK0RLa0Vqd3JMWWl0a0FKN0hOMUJW?=
 =?utf-8?B?QW85aDI4N2F3V3RZOUh4VkNDeVRZWHI2QmhNeDZtVDBpOWpWMDlFNVBGMndX?=
 =?utf-8?B?THBMYVJqcmVHY0NGYm5FRUJrc093aUc0NmtiL0g4dW42bUVmbWpSbkFnekRo?=
 =?utf-8?B?eGs3N0JQQnFXRkZ5N2U2bERHOHFKc0ZOUk5iWTFXdWYwRURDeXZaNUVsRkNI?=
 =?utf-8?B?ZU8vRURLb09iNUUrVVp4UCtlWFU1dGhMa0JoaCtia0tVaTNVemlWeEF3WEpi?=
 =?utf-8?B?a3VOZld5dU94eGx2WkVLVU9VbksvcThPUC9sU1dhRElaYzJ0aG5ZRUZRcTJs?=
 =?utf-8?B?R1YxdUtyRWFTYStnb3R6UERZblhHNTlKRWVSdnN2ZHE5UkJ3ZGZmY0Q5eHd5?=
 =?utf-8?B?a214NWp4VllMTWdzTTE0ZnVIWENzclg3WDNObzcwamUrckFIQ0RndGdvdmV1?=
 =?utf-8?B?Y3NtMFl6LzRkWFV5eTFodFFmcjZQVlpBR0o0Z1BFdkxJSHRQc1dTd3ozQ0xj?=
 =?utf-8?B?RjZhckZ2cVdnSEw1Und0OGVmTUNHekNDWGxsREFnNjNxZDVHMHdTNHBvY2Vi?=
 =?utf-8?B?bW5BUmo5cTFOWjVpcGo1b3BQTm0xQWpVRDk5TEltTlNtZjVwTWxlT014QmQx?=
 =?utf-8?B?M2IvaFJ1Mmc5YVhKK3Fvc0REUEsvQThEdXZQRmdSSlV3ZXppTjJZcFM1ZGY5?=
 =?utf-8?B?YWNvYmNuaFBMRmZvNDN0TlBiTkFGYlRkU1AxTVdwYk03bzJwYnUwQ0xUOGhy?=
 =?utf-8?B?ZmJubnBDNmhNL01pMGJKN0E2Q0o1ek9xKzZnOHBZcTM1NGZjb3I5Mm01SHZw?=
 =?utf-8?B?R3ZGdTJIdUhEdnRMU2tFaU9LRC9MK2JQOUhqcVFWU05wY1AvL3dlSi9iLzgx?=
 =?utf-8?B?b1ZyTDhDRGYzdU9uckk5cnhvK2RRdVRzclZ6S3BodTh0a3Q2T3JoMGlvU1Vr?=
 =?utf-8?B?dEZjaTliY20vdGVvd3NId2NaZUtJZUZ4TWlaL0d1TEx6bHZqdTRGRVlQRXN1?=
 =?utf-8?B?YXdYdzNLWTc4aGdobWxRN0J6NThINzE0T3hmUVFlZ29IYnJhYjlDdFVWM3FB?=
 =?utf-8?B?WWMySkg2L09ISytvZjErcXROVG8vRHgvNEJBMHZaeVBvQWlHVjg0SDlUWnMx?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c3f5b-1351-433e-b25c-08dd47460bd9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 07:07:13.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bJcj6KZbFwokp2OvAQl6CWAOuGIq3DtF+W9FAMTtfkjI4U2Iw/kqxRNk8dzyprC1uGc7Seg9s2u+lOQa6me0VL/5FoJl479AcR0pL4vqpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com



On 2/6/2025 6:45 PM, Thomas Weißschuh wrote:
> If vmlock_ptp_register() fails during probing, vmclock_remove() is

Typo: you missed 'c' in function name - vmclock_ptp_register

> called to clean up the ptp clock and misc device.
> It uses dev_get_drvdata() to access the vmclock state.
> However the driver data is not yet set at this point.
> 
> Assign the driver data earlier.
> 
> Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   drivers/ptp/ptp_vmclock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> index 0a2cfc8ad3c5408a87fd8fedeff274ab895de3dd..1920698ae6eba6abfff5b61afae1b047910026fd 100644
> --- a/drivers/ptp/ptp_vmclock.c
> +++ b/drivers/ptp/ptp_vmclock.c
> @@ -524,6 +524,8 @@ static int vmclock_probe(struct platform_device *pdev)
>   		goto out;
>   	}
>   
> +	dev_set_drvdata(dev, st);
> +
>   	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
>   	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
>   	    le16_to_cpu(st->clk->version) != 1) {
> @@ -587,8 +589,6 @@ static int vmclock_probe(struct platform_device *pdev)
>   		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
>   		 st->ptp_clock ? "PTP" : "");
>   
> -	dev_set_drvdata(dev, st);
> -
>    out:
>   	return ret;
>   }
> 

Nice catch! The code looks good but please fix the typo in the
commit msg, as this may be misleading. When applied please add my:

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

