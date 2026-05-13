Return-Path: <stable+bounces-246913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLITHC2aBGqILwIAu9opvQ
	(envelope-from <stable+bounces-246913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E49325363CB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5633F3027706
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20C47A0B2;
	Wed, 13 May 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jso9UWb0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40562413240;
	Wed, 13 May 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685669; cv=fail; b=uhG5ElKDTP+hH/+exsSKjmve+oxmK9t2ZIhVD0AANwNrQFz1TuGs++BUK7CjlNzYQ/EVIJlFOkr7Tx9du3oNDeANWVQfXLL32hGcm8QnIk35LGEzTo3nTLCdHqGelhP3iNm6SDmzfQrLAvUw60VpOWZ8L1csYGUNuq6swZNwhfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685669; c=relaxed/simple;
	bh=48L9JqtQMpYSdQz/+ejKFFjwoEVucdHmk/cqK6xe3i4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iB5zvQn0oXNUAFkfKWnt4mTacBHCFpArfvJhvOXWB8vUrExBCieBE59rPLtqln9/UmoNHD50pu/FuOrNYYxc52R0oVFynYJ1syWJtdLzD4Av90sIs2RMeS+OZ4USjVh+dAtzj0qXZ2oGXfluPly/tk7fDwLtNLmBZtl4V1KxuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jso9UWb0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685668; x=1810221668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=48L9JqtQMpYSdQz/+ejKFFjwoEVucdHmk/cqK6xe3i4=;
  b=Jso9UWb03zQF4LpaBG93q+34yvpTzL56Y4ljlYkSZM18G/JnZ9qiSid3
   5OAjzuWnb6e9qyMbic5E1kQxeuNRJ1ItXGM9GSyePQL45lJb4RjIM5KmV
   vVZTfoD4KPmRZ8hTHX8B4oHdRP5ATgQJ12pnj8qHGamgD7wJWNG5AUOq0
   OMj+cTPB29PgRTUEP4CPK7eHPLs3llk6u2PT42wBVsLI0Q7bFNL+criT2
   nVBXR7A9SX9ARmxmVZGgeQktn8e9zpW5J6bIHu5oYXwLs10MA3LwXDYRX
   wtzsErbxVamH7U6F9l4U3EmsAbE/gu1E+RtFWmiqGMVwMRQLeDcLmH/nU
   A==;
X-CSE-ConnectionGUID: nDiNb880SsWplrAESgxu7w==
X-CSE-MsgGUID: r8xvZqZ7Tty2cEwsrrOVKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79646092"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79646092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:21:07 -0700
X-CSE-ConnectionGUID: c/RBilK1QW6CR5rjjBXJJQ==
X-CSE-MsgGUID: 7KaNV+rYR1iixB5uV/EX2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="243092618"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:21:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 08:21:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 08:21:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 08:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltCoX7QqSnLNmSKMPIP+tjTe5Sl3Hz23Cf9HFnIY5Lx6i+ww7TbQYXsJDkW5F59mW9b8OslaWbO5Br8bfXSOJeetRriHt4ygjeHnATYnAsk3ivw/B34oWJU56ZNCIQp2A4qQsqhoats7imDRqn0xe9NgnYcnwf/5qqk6IHRvP5a/uuaIRmJfDjSgNvMW02KiBTd3j2JVZGHu+YdJHb5W+ZI9CrLVJLJGqEifD/Ol4FHKb87JQGylc/xviOsfgZgrDTiz0FpbTRpJaoUy3PKo6YcfzMbyKP499obuv2pFoOWvz1xr+QKCkF6cg1qC6ksks1WxUdwFtDuIj/1ShqV9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaKSVeapt2G99z6jD2sNqmkc6plHYXp33HkN8X9Onwg=;
 b=lqPGC0iRsfntK0bymk/hlOOr5P2FMljwiX8aFRr1WOF00K63J/cdW5qxbpBi7djmzSFFyfW915/4JzNdosiKAEsVsQ2BgIvnacm4fNkCAptpBr3aTftBmkyMnN+dE/4ED/H5M10t2sdjFnajlSlsMByPBby6bzAACaGT2CZkQs2o5FOJdka5CHXfjqyyTunzrizgjSpu0SJkK+qgtNL2/edpOYpoZgnhHyzQTDPIXQQjCdHN9R3ivTBZkcbV+V4lJYYeToR1ZZbsnz/v1WCvmr27RnzlKIEeJlcXbgfwMEb9abmYEigY83ZDeC3byBJl16B/qx618bX4j20ZWw/5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 15:21:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:21:00 +0000
Message-ID: <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
Date: Wed, 13 May 2026 17:18:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xsk: switch xdp_build_skb_from_zc() to napi_alloc_skb()
To: Lorenz Brun <lorenz@monogon.tech>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, <stable@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260512152658.2818805-1-lorenz@monogon.tech>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260512152658.2818805-1-lorenz@monogon.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0262.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW5PR11MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a510027-062d-445b-d4b8-08deb1033cd3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: UhIW6Xu3Z2rFhHOUJ5f7PyeyJbhH+V1w1gmEtxWRnSQnS7X6hdDzgfLIGN1MpuXqbtKFprAo25xBaAG8gl3cNyQhsTdS7mSmLSK5nGFjvtwXpx10c58tlyMb8YGnlEuPqaPWQmb45Id3y8xbL4MHI2zku3u9FafpEsbeXbrsV4VFtyBz/FKCXbWTHRLebKGVo5ggSnHu+yPDNzDBuo6NT28qRITVY7cjGj9SEaiZkGyN3KAH5c1+nowzzLI5Dha1E5/HedXi8GlUkhseE5NiUHs0BWEI4lFipfQyejCZc5srmRb69IjilGeu5zR0VcVqIaEM7ZJRku6PIJXynMq2EJutF7jwkfthLk/uaa0QU+e4IJ2G/EXvxBcxMkgZLreOxQxuc+SitSp6lTHhXsK6p+SJZjmkc6XCaqXAhesqOm4CNalCI3buHRWImPL9fadXwk7souQ9rX2bYHJyCA5ygfQkL3S1tdvKrEAgBTywj4LZwiLgTssDdb7JbpNk/jgqmdMVsRLwEnSJOvjEUX65wuMLX0hTuIOXxorM5IQz4BmGQXOAsp+phpQqDVEgt3GtjUaDULTOA+Cu/w3udN+i0sqkraUCJgurzqSYNvfo0ZkUz6wIsBxo/1pwfvk5YI/p4fTyZzdl7mSvvCMqCQhWms+NPnSRzEs8zcdYMdeqQEfFrmIhS5ROtc1SganLm9oB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVYZG5oaURuQys3OUoyZG1ZWFFVRE1PblJwNXo1YkNuSkpXaitIdU81Rnkx?=
 =?utf-8?B?cW5oZk5ibHJKMGhGMFpTdCtTdllEajRsazFxVUpxOGhWcm1zTWNpYVU2KzNU?=
 =?utf-8?B?VGh1RUlQZG1hUVhkcmVpQ1dqZUJrWGJzbkJwdkZYdVVBb1pxcVlVd3RjRk4x?=
 =?utf-8?B?N3pBRTFiODNVZ2I3OW1nZHRubHB4MWlYdUExNmFmSkhJUzEwQXVZdHdHSTlE?=
 =?utf-8?B?aS9CVTJ0WGtQTmFrSXE1R3NLVnhIZDB6TjJDSG5qbncxajdDa2xuUUtybnBa?=
 =?utf-8?B?cytzK01oOWZTdm9IT2hXSFArbFNFQnlnZmtJR1ZBUHduTFlNeXBvUkc0R0RE?=
 =?utf-8?B?QVozKzI3Q2k1STJZbU9XcG5GSnVyVUhSVkV0c2xxVGhGc1k3dSs3a0pOU3Zy?=
 =?utf-8?B?bDFqdXZJK2xVSHc0OEZYZ0tZd3MrK1dsOHp5OGxWcnFpVFQxbkgxS3VUWTI5?=
 =?utf-8?B?MmJBRXdtalpQcEJMVS9RM1pTTUtJdEZFZVVIb1R0ZWZnbnJ4cTA2NkltZHFw?=
 =?utf-8?B?RE0ya1dUcDFsZFR5VEw0blB1TitrR3lLWjBzay8yV2Q3emhMNE1wc3N1YVcx?=
 =?utf-8?B?NU42SURXRTJldTV3eTFFN0I0bzZla3JuR1N5VFhDbEM5SVo0ZSswaDJPOHNP?=
 =?utf-8?B?QjM0aEFodHIySG56TGpoR3JYQkVzNGJGTGlOQ3BicnBES2d5c1g4eXA2RmxD?=
 =?utf-8?B?QVZVYjd3SDlnQzRWd2lHSVZaNTUzcFNXVEJGUm90cHV1NW84YTUrSkpqaWsw?=
 =?utf-8?B?VXRXS3ZvWFJ3Rlg5K0ZJQjB1VnNkR1hDN3VhN25Idyt4Vzl1SitUdkwrSzgw?=
 =?utf-8?B?NFVoeFNteWo3TmJyWVZwc3ZtNnBRYlZ0ZDlwVjA4R2V0Szl2M0F1M0hSbm45?=
 =?utf-8?B?MHBjdytQbVBsK3ladDgrY1dpRG0xaDZrVTBUbXJzWmxiZzJXU3N0MEprbzQ5?=
 =?utf-8?B?SnNzMWlBTjB1bHNkZXRHckhRWnpPdDdpNkx4bVdBWGM0aitLMTFzSU9tKzV1?=
 =?utf-8?B?TU1OanpxZjI1dHZFMlNQTWsyWExSY0psUnptZnc0YlM1Y3F0V09RYjV0b2or?=
 =?utf-8?B?YnZNTXlzT05GcS92VGs0QXhEaytHTG1RdFNYMzBXNnEvdW1LL01uUFRCWEg4?=
 =?utf-8?B?MEYwcTRrUXFrVzRWY2psLzJySkJPenhCNnBhY3hmeS8rdW9jVndKTFYwd0Fs?=
 =?utf-8?B?Yk5FSTdiaWQ3V0tWUktOSkF3SUVocXV2YVVEeVErd3piNU9kYk1Vd0lNWjhm?=
 =?utf-8?B?bXlpUWdFb1RwRFVjWmVuUHpvbTduak9oTFNQUkx6S1FkTWdZK2lCQ2cvWVA4?=
 =?utf-8?B?ZnZLMEpYRW5NVVdsUndtN1VFaldJSVJNb1F1K09kbG5iSldEZlN4bVJMcUUv?=
 =?utf-8?B?S25JaS9xRlhreEk0SU5vM0N5OFo5ejVLYWF3T0l5d05wVDdrZXdIczJiUWJ2?=
 =?utf-8?B?N0FjWTZxZGJ4M0tQaE4rUC9EdVBwNjkzNkJMTEN3eXp5aTd5eWYvWDdiZDQ4?=
 =?utf-8?B?aGpobEpQNEcrNm1vVmxFcXJ1T0NZUEQwbHhEQnl1RVBvTFdzaU4xUloxZVVl?=
 =?utf-8?B?S2JrenRQZFV0b09OT3NCZ09TNVNma1RBM2dSRU5STWExMTFrTU1ic3kyYytI?=
 =?utf-8?B?QVlCQ2Y3eW1MYW9TZ25nZkIxNTFHSnZTaElUZG50eUNwSkxBSFFEbzFEQStn?=
 =?utf-8?B?MGw3QUNzMTVVZ1F1TnFxWXAyN2dsVkpqMGVrM3ArR0liaFU1bktSQ1c4c1Js?=
 =?utf-8?B?OEx3cVZhSW1ESkpnWW0ydUwvaW92OE5WTFJjdWtqYjBHRit2M0djOU1Ba2Yy?=
 =?utf-8?B?NVJjdHlCL2laR3E4K2NSMkJ5dGxIRmVWMjJXZGNjd3U1NldQYS9RM0d5N1Ns?=
 =?utf-8?B?b3BpQnE2V3VXbGRwZ25Vd296Y2YwSmFGT1pLNndUQWIxWnUzYVNGSnZtSm92?=
 =?utf-8?B?c0pRbXd2NlAxUnNzSWRQdEtQS1ZJaDZjVnBod05KenZXbTFxbm1EMW9QSWlS?=
 =?utf-8?B?cEFPOFMrYlNnWVNEb1paVk5wSzNiTU1kdCtZY1RlZklSMzQ4STVKN0Y5OFZH?=
 =?utf-8?B?c0NRNGdnUXFTSE1CWkNiNmZwNkoyb2xTWW9CUldYc0hKZEFONi9ZbmhQeUVH?=
 =?utf-8?B?Nk9mdnQvSHAvTGsvUzVqbFRmR1VSbWxra2EyYWFJVE9yTzdnQzhqaVduQnRP?=
 =?utf-8?B?dGdtTFlPbnJtaThXYkxnc25yZis3cnV2MGdEVUNENVVndCt0YllMM1l4T1Ur?=
 =?utf-8?B?YVdnMDVwakV4NE5xMzJFNmh6NHN3UVNURjFqU2pBVmV1eGlwRkFKNmJWN252?=
 =?utf-8?B?REJodk5kYmQyd01YVXIvOWIxc2ZqOFoweXJMblcrQldrRVJoTjUybHQxNzhw?=
 =?utf-8?Q?g67aB+rW0Y+R4fok=3D?=
X-Exchange-RoutingPolicyChecked: OWYo5CnPlU/rTvnDNpuce4CNKnkVXZ6BvEU2rlKdT/Pl6vjLCHjo6wsO+W6Xa6ZiTLW1udLWFVmI6Uo/a/yEAdCaZZGp+u32YD0LSxe6D3mjjoXLOEbn2NY2/SEXmPjVeZhvs7cg/Oy4RU2LcpSmIETagR+umnT2qQ0/YYvyqyukqz6qMs/IFjAHMwh26+bWRJlrhsauBmxtTNffZf84VeVjWLKk1byCKVn4g1c9BwPunt+RAuN0XilbCoTumwvYU0l+j6T2pbIhWPupXt3+GaH3WOfCb5QZH1sFQUudb/Pf7LcAKwCczEeSGSc9HvkhrTax+MeKuDociHuGD87F9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a510027-062d-445b-d4b8-08deb1033cd3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:20:59.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmHrt9BK81w7+g2ZE5jgvBUWlB7mCDwz//fjEDJZnY9oAd5qwVL/v/PVIVEww3ePffx2CQhQDxIAGUc6NNKj6YY2itkfgoqBiqBetbo76hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E49325363CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246913-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,monogon.tech:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Lorenz Brun <lorenz@monogon.tech>
Date: Tue, 12 May 2026 17:26:56 +0200

> xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
> system_page_pool and built the skb head with napi_build_skb(). The
> latter places skb_shared_info at the tail of the buffer, but the
> helper sized the allocation as if the whole frame_sz were usable for
> data. Whenever the packet plus reserved headroom approached frame_sz,
> the head memcpy overran shinfo with packet content, corrupting
> ->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
> skb_copy_ubufs() off the end of frags[] on the RX path:
> 
>   UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
>   index 113 is out of range for type 'skb_frag_t [17]'
>    skb_copy_ubufs+0x7da/0x960
>    ip_local_deliver_finish+0xcd/0x110
>    ice_napi_poll+0xe4/0x2a0 [ice]
> 
> The overrun bytes come from the packet, so an on-wire sender can
> corrupt kernel memory remotely whenever the XDP program returns
> XDP_PASS.
> 
> Rather than patch the sizing math, switch to the pattern used by other
> in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
> napi_alloc_skb() sized to the actual packet plus skb_put_data().
> This sizes the head exactly for the data being copied, drops the
> system_page_pool local_lock from this path, and removes the
> structural mismatch between frame_sz and the skb head buffer. Frags
> are allocated with alloc_page() per frag, matching the other drivers.

I used napi_build_skb() + system page_pool to enable PP recycling
improving XSk XDP_PASS performance a lot.
Are you sure there's no other way to approach this?

napi_alloc_skb() used in other drivers works, but it's sorta old
approach which is way slower.

System page_pools always allocate a full page, why can it create an skb
prone to overruns?

> 
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
Thanks,
Olek

