Return-Path: <stable+bounces-164593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0627B1085A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E98D3AF2F4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784DC26CE2C;
	Thu, 24 Jul 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6mX+Wl5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C73126C1E;
	Thu, 24 Jul 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354819; cv=fail; b=tZXvb4KN+dLmcUWekiMpCHPqDseT0CP99aejXzLSDPrQvx2nr/jIJ62Qde0rRhDsIfv7VUOh0ahhYpWoGCPSZkGeWgIgX2Okz+scLcOEOZAMAvaD55l1mLIFEMBQnlQ7pM7tBJd0G+vuAUlCkk038G4muIxrwDdqXv1ZcZBJv0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354819; c=relaxed/simple;
	bh=LLv2vDEFlYN+9leb5mL1BqMQ2HEtRKmwlsjp1Vg5OPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hv0gDBB16RBrzzSOHZBx1BM0s8UQtM+a0ELfASe291yYa1gE3GzFiBj3QyyZg8W7tmb7AkbQYClGcNDUYMDh3HSn4UjixSHEAr6pCMmrZ3ZnFSpb0ZHmBf/ee5RGJVs2SmFAWmQ4n51PvcncH95PLr+noVkSFxwmU2OFeJU9jdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6mX+Wl5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753354818; x=1784890818;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LLv2vDEFlYN+9leb5mL1BqMQ2HEtRKmwlsjp1Vg5OPM=;
  b=h6mX+Wl590nXl139LBd2+b7xnQBkrU+pd41jysuw64/Z99hBeluC4RXl
   RWQAfN3D3/rOPDJNnPqiaHFbtKs06GrxYBn0yn3H7inbr7T7MYf6tylu6
   MuksBj9kqPLCEfoyadJ8lj5qDZTvbBJaIyM1TcRliS9QUUIgph+TlkELb
   SiFH6Ez1nZRmnSVGaRv3y3ZW/L8j07ttHpF4mXDTQaYKp5z6CJwE8kSJM
   w4iY+rioJCJMQKm3XlFYGJWdyy9s4RNi5JXQClCe+GMCHWsV7MbRpKuXo
   9AJ0U0P7X7C7AoixHBie/vich+Scjp88+m6/NCsrZZPIVj37rkCJThtYJ
   A==;
X-CSE-ConnectionGUID: J03vK0+iRWmxaZdOBGvUug==
X-CSE-MsgGUID: vsHVWFzJRM+I8lCWKe/XlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59320135"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="59320135"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:00:17 -0700
X-CSE-ConnectionGUID: 7w5Ux6QgQ+6lT5qQ33azWg==
X-CSE-MsgGUID: 69pJ8T7BS2+ACD3/tJ5eDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159750429"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:00:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:00:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 04:00:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIdFrvqRkIAi/+RZ1SPNyO7Fr/qyuuAWDd/tgOIeO6IVxsJNf4Dkl1VttubIKoYZV4apZFeOXuyWWkpnGwEQjY5305j0EhSjpBlbAnhPV0xRArR2SHyh2IJc2HMWkV/lIzxBdelvZmSgxR/i43kGKaHk6sRDEpzN2Gc07alhxG2a8j0J0YP+a9iIWu2Ndo4h1w8HkAncETIxj7mC5XK9FP3Q3qM7nrQT/IVvFsbU/yj6V+horBYSY/4zAxzazjhXHl7UUJLwoDKBX2WZERKgKztkXnQyVBPNU01eKN0wyREkaX7UcMJ2Q9XUJlHwohKpsvmlWGdhA2fpEUaezLLA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYkCAJecvFZcBtmA5IM+Mpu7/vbWK7dkfuMywf+2vhM=;
 b=xSrBUufQj4JHpZdABKeLo9bYsxru6HG3rQgjtDZ+VuPewJMXmA72JpQGqLql09v0USoHHUvC1bIbuSAivSThSMT86EhU4Qv9FK5gQLRrYu1RSV5QDnxeATcIzh46fpmp/FCpKtbLI+1NNBj/1seTiDGriYMclZcFW7+r8RYhHu0mNNF7CZaoAQI+WDPBqjLq0lKW3Iu+ZtCt8Or3twE6QKrliPu9cm4WDCCvj26wqS5kfBgixJ/e84K6k4koNRFxrj4mk+fTuTHsjmWQd6W1v/VCRQW/vSfWew2lPJigKZP7mWdUVj9CgdSOSWGBhGzaHI8LUb2hh7r1P9SEE3C5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Thu, 24 Jul
 2025 10:59:59 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:59:54 +0000
Date: Thu, 24 Jul 2025 12:59:47 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Kyung Min Park <kyung.min.park@intel.com>, Ricardo
 Neri <ricardo.neri-calderon@linux.intel.com>, Tony Luck
	<tony.luck@intel.com>, <xin3.li@intel.com>, Farrah Chen
	<farrah.chen@intel.com>, <stable@vger.kernel.org>, Borislav Petkov
	<bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <bc4w3nbkjzyrwmcjodrrwg7klgg532gre5v6fiwe3jvrww5egp@zezyxzny3ux4>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
 <C723416D-E1C9-4E18-A3B2-D386B1CB2041@alien8.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C723416D-E1C9-4E18-A3B2-D386B1CB2041@alien8.de>
X-ClientProxiedBy: DUZPR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::14) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 990da863-2353-48c3-752f-08ddcaa1384b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?J4X+JIPgTEF1bdJVlrxvhvynnQ6B+BSqCuY38yFcHKle2Z2YYQ6su0lL2H?=
 =?iso-8859-1?Q?E30nsiR0MQbnyCOJ8XUkRd85kICC0JhJuzamNvki0C/BW5WHh3YKZdeuIS?=
 =?iso-8859-1?Q?q0OMTMQfkVhJxHx1CQKHEnwH2da3U8tjpBF1GG9lis+XVabm1762uQKaT2?=
 =?iso-8859-1?Q?VnIUAC5hXPBpXr2PrAtiC6RKvEp3orIw4xlBRqwDP9y6k0mQy3IQJt6ShK?=
 =?iso-8859-1?Q?NT0C+Xk86pJCJAA2uhervpWiuZxVn0SbyQ/u/bVAR0+lq4PgKbwrXXH3WS?=
 =?iso-8859-1?Q?Qsw+zoiJxOp42u0g1k/FHNQw+TV3016sK3TEU/oIeOv2Ksm2zwb+zYTTcX?=
 =?iso-8859-1?Q?hG7FqqxtNJmPCpM9zk4wASePMlymcESdOgXYrOXMRfZnAivbupltAIYIcK?=
 =?iso-8859-1?Q?PaJLLsHuxsOqUuQ5Ugqz5b9iqZdbifqu04PAYK2HC065qaA2PCZWlEItLJ?=
 =?iso-8859-1?Q?qZTEpx+GmdOEfT+7dwU40sIKLZSxrgXpMzbnd0xeVGDJvm9+0AqKO6TFn2?=
 =?iso-8859-1?Q?sOd7IEKnt3qHiF4ll5FaoS1gk05cEsH9AOIJyTc5CCJHl3/bBFdMHW1B3U?=
 =?iso-8859-1?Q?UUMSjdJJm4s4E9w0Vu2KW140CXglWNXqE9UQ1InYxsHNMpvStGldH/FxSj?=
 =?iso-8859-1?Q?eM3C8cVrqwDZr4MOwaVs/b7u4HOm5OBu/95btw/TZwdf9lAcX/8s2bF7fb?=
 =?iso-8859-1?Q?oL0GMBr6bytnd3fqMJwJG/Gqxo1Ba1lfIRqB5iJXL9Wd8oJVniaHsjIzjM?=
 =?iso-8859-1?Q?Aswbpky/+gZDEjmxxioSFmmHtxCrYlTw6l7SAozrBQmukEwCMXUiHBsEHT?=
 =?iso-8859-1?Q?xeO4RublAzDrLXtp1xbRVhk/+hQVAxlYtSLBcYl8FKl/4UrnY35WSC7v8i?=
 =?iso-8859-1?Q?VTAV76rsdtpK1ZWYV/0OLKcST/U1SaAC1albUywc7TJe0vVBlYVAkjzylH?=
 =?iso-8859-1?Q?VCOBqANYiY3bg24EYmPSO7EnhwUeKTmYZz8SKnTTdhd9Y8Ig+bjLgohz1Y?=
 =?iso-8859-1?Q?TccUkv5Ticx038S+gsZyQNLg3pl68N04LbQ3eWV6CjRG2hA+dxj/hyBWpA?=
 =?iso-8859-1?Q?Jn9Jbo/4YeAPvo1Irx6NBBdvpemkMaUe++ce/mUxYBqpV+7HVK5QeJTMtR?=
 =?iso-8859-1?Q?LV7gh///DQrlQGNqcbex7MGGdm7BAk/Kr+Tiu2Cq7K9gumi8EgbHA7zMXw?=
 =?iso-8859-1?Q?CXqaO6iU4C7nACFm/nRuzX6Yg9EPJk7Wsi1CaR1JhZTR5kHICxLstNOg0e?=
 =?iso-8859-1?Q?iqcDmHJYTgWu590xtVBPMRJdKcbdP7qHYgtNCBMUGi0de6CZFwjAT+dG+D?=
 =?iso-8859-1?Q?8E+YiFgfQmQNPLSi/GQSrPcb7LXjGkAsJtcemqtmcArIa0ktTxMUbyApsr?=
 =?iso-8859-1?Q?StHFAgA71jkL+RXJ6pKx6IXct3loWFAlcDILKa8fBCLD4mpI4CuNs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vh6al4T2sg9xd0lOf2bjjInsPQumNwOoVIr8QIVt4Rxk1fX3aMJq9j20Rd?=
 =?iso-8859-1?Q?L4uOZz3Slf8t6zwNT/pU50heSSMV48BYBqAG4QHX8G0eAVCNF//qNMNlOw?=
 =?iso-8859-1?Q?E8wv73/kx/gakSjUxKQcnNFHzvTPwD3ncOnW2vKqGS2qho4dOei5+CX36w?=
 =?iso-8859-1?Q?ZdKR44oAv4Do1UZngU3WBwNdcAiiM3YFzKYF60fdY7eewh02YReXxJUXBl?=
 =?iso-8859-1?Q?KYkaZIdsGi+6zZSPkGCioMdDVoqFpHaDxtHwZcUVyWIFg6X4YoqJg0VOAL?=
 =?iso-8859-1?Q?Ibk9ahbR9AMmT6HbcdLAtrsARpi8X3GTksY20FqPs7nZAovQMBzNED3JRi?=
 =?iso-8859-1?Q?kx3iUo+BnnsXUY6+JmZTPBOAgtkhymlcrniUFcODNPJvSSv/BcJ9oLZY8O?=
 =?iso-8859-1?Q?H1AzMc0IXi9tqv2SatFHcXGaq+FkS9Pabe1uqZNWh/Ovg8TNTotnILPkm5?=
 =?iso-8859-1?Q?zGv3D+LDbSxT6oSzAAtOwBkSMG6BJUWGZWwoubmUWmhJvqu8RrUZyNY3+u?=
 =?iso-8859-1?Q?EQZi3ao7RA6aGlS3FhraPZ3rNnmfm+10yPkkla6525helbFHdwjIXm1/bu?=
 =?iso-8859-1?Q?NY+2UIx+heDVW6Ymz4Pg0WkocV2gRO2AZMjz4oWNK3ZbGRWYDLxTWjfZQK?=
 =?iso-8859-1?Q?x+dTAyumYSv3jRWFLUyrc/iNAajL5jktRtaPv9999g4ieKUT1WvR78v8hE?=
 =?iso-8859-1?Q?qnpHJegVEPKKZqbhFUiMnuvd3jrLdpUT5VIKlV9/qfZK4YzCjqLZVXKdbi?=
 =?iso-8859-1?Q?cSPUI1VTw7ukF63C0S+2Z46AYGRtzsvboB2chQxJWutQB4saBSN69v180o?=
 =?iso-8859-1?Q?aklp8y90M+2wn9NjVW1NNEBQypljc5+xC0zzTXelsvEAiizflXhIYHqqg8?=
 =?iso-8859-1?Q?DOv67NtUY2ignBl9J3SMmA8knBEPi+lCjRP7phn+48o2dig0IS06WePIsY?=
 =?iso-8859-1?Q?CPQJqRCWn9QvvkOBUVTCL81qV/XDcsKAtKCnGNxmXnVW4ExvBH3FPnkDsZ?=
 =?iso-8859-1?Q?VdxUmXcX9FnzpGFiE9a8v9/De0WDWT4SBv2G/DPrKBfl1tweJq8iVDFlU+?=
 =?iso-8859-1?Q?AiNKNglbwYGt3qse64bgXpWDEQcMMojd1uBWJE/xtj9kBDKY1WLjp3SDqh?=
 =?iso-8859-1?Q?cfZy0rI6FWZWQTQtPgyoAQ/gzj7k3AupLTHvdn5smyWa49stUNPE089zvA?=
 =?iso-8859-1?Q?STlgU4aIpWHRoCb+2HMZ1NNeqOM68uXMAoEAILMdM3m277l3FPcpF2aOny?=
 =?iso-8859-1?Q?YVu2mpZeXyCua6sctOKx/4QWAN8HTrk5yNBnHp6YoQADlUoDIV1zAk1P9L?=
 =?iso-8859-1?Q?SxKW+75mMswV75/IuwLzlqywIs/p8rQcaAicOw8nXphX4vgx/dsr2TxZRF?=
 =?iso-8859-1?Q?220EHt6+Og8XovmQaggriv07BSWIL3/Urv13ALS0ROph+jCqetmKDvXdp4?=
 =?iso-8859-1?Q?DJ1c5DG6pg4p9ph5gOzuGHLrLR8EMTLOQDxNspA/3QBFOIEp4AWiMD0whD?=
 =?iso-8859-1?Q?jzQwzJdeM0jRttUo+u5ZleoHy1E6E4Pc4VEAZ6LzvmJShYBNLXP774ILUj?=
 =?iso-8859-1?Q?GOJHP7hrSpnFWMgObHlwYn+6DQpefrMF6JtaRrIRfmyXssc/k1fFlK/j9K?=
 =?iso-8859-1?Q?8RAi825aTEmeL1A5zGgU44u1pWUvOpgu+rbJsnMIO6abg/PIBu/NUzxKRt?=
 =?iso-8859-1?Q?9Nn/F6Mxh4320b9N+MQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 990da863-2353-48c3-752f-08ddcaa1384b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:59:54.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P98NviWdD4stTOyzXx/R38TusC8lpXkd+P2aSUo5GRlMPuCxBFwa+aPxyTJya6/d1xRFmFujXyeXpJgULJn+YrcW/FbZFMRUjQFV+DWyTec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

On 2025-07-24 at 13:12:33 +0300, Borislav Petkov wrote:
>On July 24, 2025 12:45:51 PM GMT+03:00, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com> wrote:
>>If some config options are disabled during compile time, they still are
>>enumerated in macros that use the x86_capability bitmask - cpu_has() or
>>this_cpu_has().
>>
>>The features are also visible in /proc/cpuinfo even though they are not
>>enabled - which is contrary to what the documentation states about the
>>file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>>split_lock_detect, user_shstk, avx_vnni and enqcmd.
>>
>>Add a DISABLED_MASK_INITIALIZER() macro that creates an initializer list
>
>Where?

Oh sorry, must've forgotten to save the changes after I renamed it. Anyway I
just sent the corrected version as RESEND to this message.

>
>>filled with DISABLED_MASKx bitmasks.
>>
>>Initialize the cpu_caps_cleared array with the autogenerated disabled
>>bitmask.
>>
>>Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
>>Reported-by: Farrah Chen <farrah.chen@intel.com>
>>Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>Cc: <stable@vger.kernel.org>
>>---
>>Changelog v3:
>>- Remove Fixes: tags, keep only one at the point where the documentation
>>  changed and promised feature bits wouldn't show up if they're not
>>  enabled.
>
>The behavior was there before. Why do you keep pointing at the patch which documents it?

Is my assumption incorrect, that before it was documented, the rules for feature
flags were more loose and afterwards they were more strict? So before that
documentation was written it could be classified under "undefined behavior".

As I wrote in the v2 thread, based on what's in the documentation added at the
commit I pointed out, the behavior is a bug. Features that are disabled -
due to not being compiled - are showing up in /proc/cpuinfo [1].

[1] https://github.com/torvalds/linux/blob/master/Documentation/arch/x86/cpuinfo.rst#the-kernel-disabled-support-for-it-at-compile-time

>
>-- 
>Sent from a small device: formatting sucks and brevity is inevitable.

-- 
Kind regards
Maciej Wieczór-Retman

