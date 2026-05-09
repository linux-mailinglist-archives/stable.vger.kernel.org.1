Return-Path: <stable+bounces-244852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACcrF0x+/mnjrgAAu9opvQ
	(envelope-from <stable+bounces-244852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:22:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6114FD038
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CF4302675E
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109461A9FA4;
	Sat,  9 May 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJC6ou/5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF9C2FD;
	Sat,  9 May 2026 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286150; cv=fail; b=qr6cdlUjikqiuR4/+KgDbTl+yveh/Ygl3FlI1AiFfGDZqHcvFykrP5ZFeQqRsybLcRNQ6NS5SII5kOcPAuO3tvFHzNuzYR+GB84nqWBHCswBI2PlftkdINQJ0ZGTNQR+bkIfwfvahLW90HpyfEEBgfN9Wpxf3Da1XvCLhOmOleg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286150; c=relaxed/simple;
	bh=KDUg8VV3+b2iktAOc4/Lfi2H2n8E81Y6849w9tS8bUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZMf+OyF5yccFy1yCjyvrkomAdcbYvXBkHimYP0mjqrUNHJQrhfCS7lY1rN0Xas+lD3qyLWap0n1Q3G+WDPXW7CgyyzZBQGnwhRbUKg1gHwfpmXiL5fjdX3FjivQWI/wUYw8G7xc3WYDzYczrCHX4pnvFqWOSsaxLRgA3RJipoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJC6ou/5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778286148; x=1809822148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KDUg8VV3+b2iktAOc4/Lfi2H2n8E81Y6849w9tS8bUo=;
  b=kJC6ou/50ik3BD5hC8OLn3DByb23RBBgfQ0nIsaPFPBrxBhvcdwB4m20
   0U2Ma/hUvLcZyu6wJ2HtCO3Ob0i+9BRGsQHZ/t7Vl2ycKGClDLPcrNSqg
   ECOgbi/e79ALUxWWWeaeJH1loyYF0d+nP7RPGvKdF2S8sCXaj2Do2Ie4M
   FcZwBTwNOJqvsLnRqA0k/x/VvUmo6Qig28J0Oqfy1Ev1WcjJUYIDXKvRy
   O4ki3Z/HAc1iOxRDb6GA1MTXqkif0/VKyzOkSXWQjk8EhZ9xErt31yd7U
   QAbffJCEBAOKJEl72X5XfyRS813gFXmsXAk9NmJ3+nyRJVKeJ4j+c9psw
   A==;
X-CSE-ConnectionGUID: WxVTTVanSGulqaXRcgWm/Q==
X-CSE-MsgGUID: 91CrvaKMRdOsMY3ZU58O6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90370739"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="90370739"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 17:22:27 -0700
X-CSE-ConnectionGUID: 9U5f9cGwT6awotwEX7iVBw==
X-CSE-MsgGUID: fS5woHXxSvGQQ+4GIe2zLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="230511962"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 17:22:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 17:22:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 17:22:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 17:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIadrBvulDlXXLyLobY6DQnC16vfluPUVQoRAccuSVDcdrgp51hPPydpt5Hymv0yVrKrK/MU3e8zLWSkgao/Cr75d5XqDhpyRwmbX3oP3Of+wchKNq/SmV4KB6gEMdFjDnhJKp/WnTyo/7pqPLxaXSOstTfhjerRojqOVj8pYjG6QzmobbqGwa5NtUBLeXRS3IQS47wgkL+BNblyFgH9Jot8EP30sKtXYHPX1aDtDbL1lyWlxKhVjrDXhgIKgGgbkEk8KWV781DzpkQ4AxLnvtwqv9ZgxQmLu/sUBkb9P1HlA6V+/S16gkO+dQTPA6UMYhG5xkxlB5Pyb4ppyTs6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkf88Wfqb8KBPOvOm73v0edjzM02ZgtvfZzYvGxAFoY=;
 b=OPAIpGForPO3Pg7Kt+8jzH2jKUw/uCmmRUyWOP6+R/FWaDhL+TvtFqBd+He++Rbrq3onbfOvwny72opMV35D9H69VPDZH5qwYJssv2f0NxwPEqwI9qbue33+FCwx+vC5+KmTmDBN9NvCsMFep7OJ69O1qF77mTS6v4QUcERyjca6gfwK4VaPWv+ZgOMNMsCDAsjPYwfoiXpAWUasjm0P3flo8x/39Ry+fsnhk7UDlj6WnqWajtgnZZCuyKUuzy8fjHtab+cgwURclOEH6EwPniiaTAg2icGsaVUuSGt84chIigqXoRRbKV9jesOkiKxE/mCTk9YYtCk6iG7xbhHqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 00:22:23 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Sat, 9 May 2026
 00:22:23 +0000
Message-ID: <a55c7754-43a5-4ad5-a429-61c428544b4e@intel.com>
Date: Fri, 8 May 2026 17:22:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix missing 1's complement
 negation in GCS raw checksum
To: Matt Fleming <matt@readmodwrite.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>, <stable@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@intel.com>, Paul Greenwalt
	<paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260501095717.1032151-1-matt@readmodwrite.com>
 <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
 <afxbZjldi1OC3HmS@matt-Precision-5490>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <afxbZjldi1OC3HmS@matt-Precision-5490>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b57a80-d7de-46df-7ddd-08dead610a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pb8W2qHR5MBKSh36Ft0GYzFP62z+eGSwOKuoBLy9/BXYXuZJxOK4i3IbLgXDCnXS2fe75INdrZDtKKbjRxEMmfnBAx37v/Qv7JFrDRrbbUaEU8sG/ln86K3bks0HiVio5Fi5f4IjzwfkLJSfFuQWa6ekXpgvm4Ic6xFYU7W71yxLYKt0Lv7OQN36sEllsnW15ivd0X6PXzgV4BI/A2HRPXLM88sdoUN6B+RVbj+eOlYybZoa4shfrZH22l9czBnA5vbTOnL9DjB3jeG/dTpFYeZDTK8EiyTHate+Z8+QwZcnzM+3HOXTTi07maUnGy1DuCHoFytciMV7PZgsGCAO+Ms3fDBoqOIl7ZNGqhjXK+210uvpxd4YQDABt/RXrceWRdiGRGHn7ajL8iU7qn3RtJYm7VpAXyBLGy1nyMTLc0L068rGn9TCqC/bmTG79Aq5lWHAyO203BQZ2xRJvpqjg/f58P5XW3eEtTvlvZ7igyQ8sKVtn0MM9v519KIMsQ08qAteT8oLpeD+dhAOdLogZjdLb2OrB92SVac6VBS5OlM/qHJfGtqLX+B7gBj7qpboM8C9R7zdjvMYKroZiNFiE9ZJ1qnA3EOzt1UP0epA0lgC6gKa9PtdKhlu3z9uVCeQQkmPPfCYCAkIae/hUHnVtUWVQLr8IGUQZSJHe3Cju/6NZSkKHkT9PWGm0m2Vcw0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1d0Q3JsakVzTlUzWDBPMkh5cFVkQUgybndFaDBKSlF4UkRwcFBXVUNFQ1Nu?=
 =?utf-8?B?WndzSkt2NU11NWcvMEg2WjI3VXFZV1ZDQnpTL1ZLV3Y5VjBqYlVvcjVIY0JE?=
 =?utf-8?B?RXBORkkyNy80V3Qvb0o4cWg5UTgvTi94QXJMWm54dmlkd2YvTGpIRlF5Y2VB?=
 =?utf-8?B?cXkyT2dVZlZna0RaempTTldMR25KRkllS1BxT1Z1VmMyZjBoWDVvNVlSZHFZ?=
 =?utf-8?B?RDU0UGJHb1dpTUZ0UDR2d3RLdkY1RlJzdm5Yc0tqbDVzVDdSMW9XcmFuUlZ2?=
 =?utf-8?B?SnBWMU1XUlI0dWFjWTBSQkFRTHNod0lJSVk1UVpWa29uZWdmb3hxc3grNmUx?=
 =?utf-8?B?RUlUOURKb2lqZDBVaVYrUE14MkJRY2pCSnhDbnROeEJ1cG9VaGJpMkovVm5I?=
 =?utf-8?B?UVlkV2JBbXQ2ZzZuRDhQOXRUVElwUnA4MldwTk5qZ2JTUW02c0xuZVRGYllC?=
 =?utf-8?B?TEtQYkNWUjBwVHA5Y3pwT0YrNk84d0ZYM1ZmMGZaZENEcE1VYjNwRjZmTWVT?=
 =?utf-8?B?cUhiK2RTbnJML212TzZUWXFEc3V0RUxSa05xbnBvUFJSRjZYM0FMZkJSTWp6?=
 =?utf-8?B?Q3NibW9mVjRjVFZZNXFidHU0eG14ZTVnMFNMbkpwVEVSQzB0SUE2VXpkTXg2?=
 =?utf-8?B?RndtOExVZWxkNkRQY3l4YjRnejNmYmhucTErajlTVG95UlY3dFg4UnkrdXln?=
 =?utf-8?B?ZFdZYURqakdvRVJiMnpzMzRwdXJGVUNQMmFGeVlxb3l4b0t2eTR0T004czVn?=
 =?utf-8?B?VnBFVFA5NlNyT3NXWnMvT0d1TEVwZTRjandxTk1wMjEwZFVhV1F4RUJUQk5r?=
 =?utf-8?B?c1ZwMXM4a2NQdkdqV1VDQmJKcExIZnlIMEhYRDZ2b0lUc1dTWHVRUTY5QnRN?=
 =?utf-8?B?UzVWRjVTaEVZRmJKNmZqSTBJRXExMWVlVzZFdlN6TktxWVVuOU1KNHhsV2pY?=
 =?utf-8?B?amNTamM4RnZxYzR0cFpHVUN4T2xmUmdZdW1sN3pFUlROQU5iS1FJRzVWcFQz?=
 =?utf-8?B?ZC9FOTIvQlVBN1kwWUNDWXlNOFU3d0w3VURsTld6Q1Jib1NyaUJxeFA1VTlp?=
 =?utf-8?B?TFZ0ekNXcThGZ01BTVZZNDdJMmtCYVQ2c0FpU0tBZU5xLy92ME1hUzhmRWdT?=
 =?utf-8?B?Y1ZkdjZuRHpFZE5DMkFPYnM0YVJwMEtESkV3Q1RsdzhvSVFacHIrVzdLb0tC?=
 =?utf-8?B?Wmg4b2l3MTVQMmNiV05zc2s1cFBDSzFVa2Z0Wmk1UWpBNHJhVStOSWtYUnQ1?=
 =?utf-8?B?WllDV2Zyd2loTndYcC9UeWhKTlNYVDR2TFFHSlN3NDM5TS9vSlZlayt4NzFh?=
 =?utf-8?B?eUkzNEJ3bWcwYndzZ1Y4bUVVVFFSNXRjNDJmZkJzbnVLOHpsc09JUytIQ2ty?=
 =?utf-8?B?d0J4TWJ4UHA1cXJxSFZjRUpWNGl1b01kV2tBcXNoMktjeHlPNUJsSEpCYmd2?=
 =?utf-8?B?K3NDOVFKNFhER09uN0VTTlRjKzVlUWVGZXRNaGcrYk0vWHBMODA5b2JTc2s0?=
 =?utf-8?B?Q3E4V2tneWg5aFhqT0ozVjdPQ2J6Y0x6R05SUGRUcXc2bzhWMmMzLzQyYktp?=
 =?utf-8?B?TUFXSUZZSGF0cWlXNlZJYVprRmhuRE91aDVpbGZqb0xrcWZoTkFtbmJYSDgy?=
 =?utf-8?B?RnF3VkZ3T0ZMZWVwYnNoUHl1N0ZvMzBiSXVuR2lPdE1lck4wTWtpVVJESlhQ?=
 =?utf-8?B?MmluTUxXY1VJQTRsc2w3azN6QWxmYmN5c0VNcCthbURmM0JKV2ZDMnZKK0R4?=
 =?utf-8?B?RnA1dURETlpiMnZrNTdjR0t0R0xjRW5xN3VRcnM1ckRINWRNNHVIbTZHejVh?=
 =?utf-8?B?Q09NU2JLMi9veGRRYWd4Q2F0OFdYMkE5c0IyR3greHphZ0R3ckFQUkJDNlhl?=
 =?utf-8?B?WGRHOWRJTyt2eXBjcVJXbmU0STRkZTFtampWV09LcGs0UkhiVHozWGpGWmRk?=
 =?utf-8?B?WlNZaWl6NmNiR05MRDJFUjhkWURtNjdMb24vcWIzblJRUURscXlXaTBTUE94?=
 =?utf-8?B?SHp3U0ZPUGw3VWZpUCtEOWU0YndKY24rSEEwSkh5ekpPc3ljSWwzczg4NjNH?=
 =?utf-8?B?N2toTDJONWU4enhpNXlkN04wUjFyc0xpODFNYkVmNFhVQ2NpNldtTDdmb2dj?=
 =?utf-8?B?TjVnc0hMaXRoQVVUUm5IVm82QytabnZaZURFMUtFNlcrck95bGxoZWlicE43?=
 =?utf-8?B?Y241Z3pRQk8wdkxKUGRBN1VRODlXTFdwU0dMRWNzR3VGV3crWmM4WGJUT0Ur?=
 =?utf-8?B?L05GcnV0Z2pkWGViMnppVEt4L2JlSHZIeWFGN0Z0c2hPd0ppMjVySTN2eWsz?=
 =?utf-8?B?MUxYUUI1MEVNVkxPU2NhTXI3VlRmcUY2OXdjcVJPTTZzNE9EOVo4UT09?=
X-Exchange-RoutingPolicyChecked: lR5Z7RCGcGIq5NdHTM4ccpzB7ybA1qCMlX9aliSTxuKMHzJI6Fs67E5i0a+iL3eOvSRm6tr0xWGM1Q86KJckfGNjYKCi63ocOUTcu2zRsUFLUb/1Mqqutxk+oRnjY0WDuT+9YnUZmbLy+6OMYFTmaSavulLOv62D4OA1Nax7qusNUAJJI55Rtk+3WFrXY3Py9iiVlMvqXbmpMC74Nyz7H60BbE07RjegJiJzaeJhWR8fOieTYSgvHWb41GRqWAMGcoJSc6dkx/5XPGzNXi5LK0YTjHRS4W7JtJn/3Vzg3jt6NKT4hXcZmsxYInGO2JPF+0hjrBWwTjOEFyQLsYmmmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b57a80-d7de-46df-7ddd-08dead610a87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 00:22:23.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzqf34uL+/gbvwuYwbWiOVOIQ4ziCu1wdaNvzGKW7jV+Q2ncYv+rgYtd7naVYavW7x81jjyYGgj7Re+fVCqZj6NX+6B1k94VpYGddJSWu9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BB6114FD038
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244852-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2603:10b6:806:343::16:received,10.1.192.143:received,10.60.135.149:received];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/7/2026 2:34 AM, Matt Fleming wrote:
> On Mon, May 04, 2026 at 05:10:23PM -0700, Jacob Keller wrote:
>>
>> Hi,
>>
>> Based on your patch description, I assume that you've tested this on
>> real hardware.
>>
>> I dug a little through some of our internal changes history and sawe
>> that it looks like the hardware has a register setting in its
>> GL_RDPU_CNTRL register which determines whether the checksum value
>> reported is inverted or not. In E830 hardware, it is supposed to be off
>> (i.e. the checksum value reported already matches the expected setting.
>>
>> Perhaps your device somehow got the GL_RDPU_CNTRL register set to the
>> wrong mode and that results in the swap being necessary. Hmm.
>>
>> I'll ask the team to see if they can confirm this behavior.
> 
> Hi Jake,
> 
> Thanks for digging into this.
> 
> I read GL_RDPU_CNTRL on our affected E830 and the value is the same on
> both ports of the NIC:
> 
>   0000:c1:00.0: GL_RDPU_CNTRL = 0x0020a275
>   0000:c1:00.1: GL_RDPU_CNTRL = 0x0020a275
> 
> Decoding bit 22 (E830_GL_RDPU_CNTRL_CHECKSUM_COMPLETE_INV) gives 0,
> i.e. the hardware is supposedly in "not inverted" mode, which matches
> the default you described.
> 
> However, looking at the data on the wire I see:
> 
>   - netdev_rx_csum_fault fires ~65 000 times/sec on this host.
>   - bpftrace at fexit:ice_process_skb_fields shows skb->csum =
>     swab16(raw_csum) directly (no negation), e.g. raw_csum=0xfb4f
>     -> skb->csum=0x4ffb.
>   - At fentry:__skb_checksum_complete the upper 16 bits of skb->csum
>     are 0xFFFF on every TCP/UDP packet -- the signature of nf_ip_checksum
>     adding the pseudo-header to a value that was the un-negated raw_csum.
>   - fold2(skb->csum_at_fentry + skb_checksum(skb,0,len,0)) ≈ 0xFFFF
>     for every packet, which means the two values are ones-complement
>     complements of each other, i.e. the driver stored S where the
>     stack expects ~S.
> 
> Negating the checksum makes the failures go away.
> 
> Thanks,
> Matt

Ok. This is getting strange. I checked a system I was able to borrow. In
our setup, we need the existing code (no negation), otherwise we see
checksum failures even for simple pings, including the initial
DO_ONCE_LITE stack dump, but I can see with ftrace that
netdev_rx_csum_fault is firing every packet.

I have the following on my system:

> $ lspci | grep Ethernet
> 17:00.0 Ethernet controller: Intel Corporation Ethernet Controller E830-CC for QSFP
> 17:00.1 Ethernet controller: Intel Corporation Ethernet Controller E830-CC for QSFP

> 
> $ devlink dev info pci/0000:17:00.0
> pci/0000:17:00.0:
>   driver ice
>   serial_number 00-01-00-ff-ff-00-00-00
>   versions:
>       fixed:
>         board.id N31483-000
>       running:
>         fw.mgmt 7.9.5
>         fw.mgmt.api 1.7.11
>         fw.mgmt.build 0x2bbde9a9
>         fw.undi 1.3910.0
>         fw.psid.api 1.20
>         fw.bundle_id 0x80017eed
>         fw.app.name ICE OS Default Package
>         fw.app 1.3.43.0
>         fw.app.bundle_id 0xc0000001
>         fw.netlist 0.0.1100-2.53.0
>         fw.netlist.build 0xf77b1d74
>       stored:
>         fw.undi 1.3910.0
>         fw.psid.api 1.20
>         fw.bundle_id 0x80017eed
>         fw.netlist 0.0.1100-2.53.0
>         fw.netlist.build 0xf77b1d74


I checked the GL_RDPU_CNTRL register, and indeed the checksum invert bit
is clear, matching your report. Even so, I see the opposite behavior you
do: we need to avoid the invert otherwise the checksums are reported
invalid.

Interestingly, I tried writing to GL_RDPU_CNTRL to set the invert bit,
which appears to have stuck but it doesn't seem to affect the behavior.

I wonder if there is an NVM difference here. It is possible that our
boards have a pre-production image still installed, and that might be
impacting the results. I've asked to try and have the devices updated to
confirm the behavior...


I'm suspicious that somehow there is an NVM setting that toggles this
behavior and which doesn't seem to respect the actual register setting.
I haven't been able to track down more information in our internal
documentation yet :(

In the mean time, could you share the device ID and firmware data from
devlink info? Feel free to reach out to my Intel address directly if you
don't want to share something on the public list. It would be very
helpful to know the device and NVM data from your setup so that we can
try to replicate it here.

Thanks,
Jake

