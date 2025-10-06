Return-Path: <stable+bounces-183446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7EBBE7D6
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405BB4EF6F1
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524EE2D77FA;
	Mon,  6 Oct 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPWfxPQQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE282D73B8;
	Mon,  6 Oct 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764471; cv=fail; b=gbYcXTEas751HnffUOIpzBDVzp0Xd9Gf6V1FsXMoJGTE1jp9yZIGeq4Fig64GjvV9nCJU8C2X9QkREsfy0EOePY2Vw2KZv3YWM4ZN+54Phv8bwVbzml8dvT1dv+c9y7mNKsXYBGs8/1C8DM3bI9M71mwfLLE8DAx49Q6ByrNW1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764471; c=relaxed/simple;
	bh=46aiHp3oFhaV03MmxIyr6ycXiN8B7dNTX7pdtBcUd7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GcOqbrUnpGs4pHRkPKAqdugeBZ6sXK+WNXK4suWKHQrGQpmJlkRO2dg9BHltabkBdTJuOI6qHo2MW4TMeiayPwZhuycBeH1bGO/mRMjM4xXr0wFnJJJHZOxy7PakGIDboOq98aP6d6mkW5zR1AASfilN036ic17U+3hny7MN0aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPWfxPQQ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759764469; x=1791300469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=46aiHp3oFhaV03MmxIyr6ycXiN8B7dNTX7pdtBcUd7c=;
  b=SPWfxPQQHZhMiCBmGJ+hTR0azLyBDfCGYlZpb4P/uSDhmcOSVodZaT5Z
   2VXX3Pk9Riy4tNMe0n+B9zPXtRiFHbIK/I9WOxjpLKPPvSoupCh6JFgGj
   wfHRtW62EQvj5Q83bwQI5rbjWs20hHbE23RIY81v67QxyqOPxVIk8Lsfc
   mzzY1Y2QSBp68E7yWSAodpDlJJ9+0e2jaLQ/6bgHv5OX6xyXh0wsJo2qJ
   dcBdvXKNSGzGgW3u2vx1UiiZT0tcOHesRi3tSX8BA4Vdsbfn0Xe4Q70CY
   QVIbOWZp1YZRMoq4vWk8KCrgg9onDf/WMCcz9KApEuxHEWlzlS2jXyB5H
   g==;
X-CSE-ConnectionGUID: zrJNuW2sSgqCV2cTL7L0Mw==
X-CSE-MsgGUID: TPSmxXBrRHKz5IlopFwxuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61824134"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61824134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:27:48 -0700
X-CSE-ConnectionGUID: izFkIQQwRs2c9E3nPmom9A==
X-CSE-MsgGUID: eSigs3paSHmEZuJh3JYf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="184185544"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:27:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 08:27:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 08:27:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 08:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9POc2PKtJmAiJ6FpjC9mXW8xvLfWoD6cup85D3e+A/Hkeds5mEJN0ES26z5DOqhdTExWhqXUf+tmJw3C1wpNsVKMNxHESQdqKjuhwtHfWDKEcKN75TkUpKbvcVijGi8I2uCv9XkqYCewczmyiR01TBjq+ndhnVjlRFMU3JQCOtmTvTE59nlDSuNOpO61bPWu8lh1JobRuyU4FLhOHTtWnkAJvE84ba0M7IO75ob50xy3N4nE2mlvYK+rej3+UwctWbiZr8wVqIJjNQz0YuctHzpItjCIix0wrwEIMxwXjEhEmJRePWUl/G96msFgz5NNMMjIvgNhbI1l5okXdoXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTnW3FkrDY5TG3Mjb8BK9Rv8VKALDr72oC2yPwWkLCE=;
 b=GUWLZDrBexGFTPaNfxjl6w/4IGNIWZ3XYrhOCPgsylmjyiRl1X8NNOXfY0vl3bjId1RQ56Oqo8sjaopFQmaDUtZ3v+mBqhG77s8FKVC8KdtlHvlqgOz8ODgUJbiFPEJwV8jw8ZnAfhhCjZ3Z7PlACcADq517LSwSE0ggRQ8wwbvMjGF36lNWoXzyMAIA7A1xQuL+qsDmcjNMqrs8IvEcnVZ8UWS1+q7Tf+pibWmqvKrYK2TCZmH3tMaRJzY1OEeYsdmb6CmjHfgUJqWLp6y+A9eADuVwcpImsdQZUEDEoBVxR8NJMx5cMcV9AVv9/3mDWtG9YiQtalqMXFwSYu7vFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV4PR11MB9515.namprd11.prod.outlook.com (2603:10b6:408:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:27:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:27:41 +0000
Message-ID: <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>
Date: Mon, 6 Oct 2025 17:27:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Emil Tantilov <emil.s.tantilov@intel.com>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
	<phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Chittim Madhu <madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
	Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, <stable@vger.kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>, Koichiro Den
	<den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV4PR11MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6069e51f-ee40-4412-0ee9-08de04ece3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2dSd0RWR0FzcUFOZTFYZTYvLzA5T1hnL0ZzUWMxcUhwbDNVd1AxdDVuRFZS?=
 =?utf-8?B?SVhKUGdRZFNIL1BYZ2ZTSUhyRzQ4bXExcWlmTXZqd1h3SnEvenpFcDZFZitF?=
 =?utf-8?B?Sml5RlU5T29QSnlxWTUwdS9iTFNGb2RGQTRRcHljMVpucVl6b0xHOVF5NUVn?=
 =?utf-8?B?N0lmbDRoVlFEWFBURGlGalRQZ1NzVnRUVDAvZC9PMUpieGxjZGhvZS9zcERz?=
 =?utf-8?B?bXcwQnhPVkdOVlExV1lMdlpPMEhLZTBGMVRRNXVyYWNtYmRYbUs4d1ZUWmFF?=
 =?utf-8?B?YmhqcFdxLzE4d2U0RlVPd205WThkL3Fmc0V5SUw5a1J1bWFURUY3dFdtM1g2?=
 =?utf-8?B?RjVuN0ErY3prK3JzY3hwblcwSndXaGlYczJmY0tCTkRvT2FNZFhwN1Zlb2tm?=
 =?utf-8?B?cnA1UVpoRkNBbjlzWVpjOHpHejFBbldjZVBoSUV3YitaVHJaaGt0bGZWY3BD?=
 =?utf-8?B?N29jb2tHdS85ZWpGemE5bjdLd21ncTJ5dG84YUV1UmhsaFFHbkNnVzNQU1ph?=
 =?utf-8?B?WkdwNTlCMXZBTFhxQmRTdktGQmtuS3pqTEp6OE1KZWlHRUp2ZGVMUU8zaXBj?=
 =?utf-8?B?a0g3WG9BQUpqdmg5WnV4SDUvVnZwUno0cm5HdmlkbUlsbXl3c2dqNXFaSnBk?=
 =?utf-8?B?b1hmSGxrOVJ0azhVL3VESlEyQ0I5YldLRFhmaFd1WmFDb29zY2VkTUZoVXZS?=
 =?utf-8?B?SVJaN2pYMm9BL3U1aExKanFYL2NxZ0RjN29xNUI1Q3RpcVUvcEJxTUtVQjBS?=
 =?utf-8?B?VW1FS2xhY0ptTjAwc0VvdWZQUEh0ZDNmdXBRbWxlQXlzTWJJMGc5OXhKZVor?=
 =?utf-8?B?L1FZeTNUQ2VKMlBpYVhDVjdYM2VZVjNXcFNDcXgzNVgzZXJrbHc5NmE1NEpN?=
 =?utf-8?B?NDF3bmZsMDZrNlA5ODhmYy9DYXpDVFBaU0xKLzFqcEJIUTV6N2N1Ni9ZMEw3?=
 =?utf-8?B?Q3Q2Uk5hYTJvV3pXWXFhelZOOEhhYmlDUWNSaVBRWjU5WDVxUlAwTkZIR3ZV?=
 =?utf-8?B?UTNTY0FxM3ZCcXoxSVI4cGtJMDlCd0FWTUhLZVYvRzNsVzRYNnQrZHFlczR2?=
 =?utf-8?B?RmNyOHRqSU02Y1ZTRlBCSno0bzU5bjF2ODdkMkd2OTRRRUtNdk9GVUtzOUlY?=
 =?utf-8?B?K01zOEVvT09ZbmNXTmtHU3pYbXZOYkw1dGxTZTF2YThEZjhyR3AycStiMktE?=
 =?utf-8?B?SjJqVHJCMGRMYy9sa09iOU5zaitOMVNOY3Q5OHBpYk0yTGxLV1MyTWZUTW5U?=
 =?utf-8?B?L1RwK1hNbklqd3JHbjc2NzIvalBNRnN4dmU2V3VrbkZGU1lRVWh2SGI3ZEFZ?=
 =?utf-8?B?dWk0UlQwdFJRSXNuMGNmWDh3YzBTWDB2VUx1VVJVd0dFeG9tYis0emcyTWNZ?=
 =?utf-8?B?eG10S3lRU09tciszZWFaOFhQM1J4R1FFSnZOY0hkczFPYlZMeVduRFBzbTRX?=
 =?utf-8?B?RXV5d1FpT1FmVXR2MkRRNkJxdlREL1owYjRTdmx4TTJtRmVpL05paWdnOXdY?=
 =?utf-8?B?bkdkQkcvMTFGa1h4OFRXbFFQSXdadWR0eHcxbWFSdi9rQzdud3Y0QVVBZWNj?=
 =?utf-8?B?WERYR2dwQjdQSXRJWmRsVWREOVBnTG5idXdnM21NUFFtMHBzekVDOW5mWGhW?=
 =?utf-8?B?VVlaeUU4RWQwZFNDbVhPMXFFUjVhY1NTQmZ6cVo2VlRVc3hlSDBscW9ORTJy?=
 =?utf-8?B?RVkzUmc2dnN5TU84MmRpSnZZV3dUa0RUNVZRcUVCVjVOWUx6VXdsdjNpUmZZ?=
 =?utf-8?B?UGhOT3EvOWtzN1dPQVV6R3JMeUNsUUF2cWlUbzRDNkl0MUYwd0VQOUVrb2l3?=
 =?utf-8?B?dStDZjFWYkJmSEhTa1g5bjNsWHk4QVc4c28wSnlIeTd4VDI5eVVHcGJRSEVX?=
 =?utf-8?B?a1FYUVZLUnV2VnZvYzVBUlJGRFBHNi9yMHRDS2Q4bC9scjdyeUlMZUtsU1ZU?=
 =?utf-8?Q?XRka+5prWLJ11+0Sql+Zr3xGvgNpmgUQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkxxa3p3SFd3V3UrT0MxQ1l5cXBIdjh3VHo0SDVEaFZoUy9WVEJUMXA2MTFj?=
 =?utf-8?B?RU5obnVmeGx0RmtnSzF1Vmx4QXdaUVBXU0ZMejloYWhJaS9ZbTkxaml2L2Za?=
 =?utf-8?B?b25hMy9GMjRYYXkxUHV4Q0RiZmpuRU1yRkRnc3pUVFUrTVBEaDRacGRRSk5v?=
 =?utf-8?B?UjVnTG9uUTN6RDFyS2lFTEJhNWJLWlNCZ1Q1dExzTTRMdHlwY1NIVTVWMWhZ?=
 =?utf-8?B?aFdTWWhadnJZT05MOHFIL3czK0lTNkNUczZadE1vdHdsb3NFY2ZKUW9KU3Ju?=
 =?utf-8?B?d1I5VjBnYjBEMTU4UWpBdFpiYTdtVkhkYjlTVmFTRElYMTFoMCthaTlmRUxP?=
 =?utf-8?B?SkxTM0FKd2ZHOXE4eTU0eUl3WXFWbXdFRHdidFJYdHJUTWpMbVREdEtXMDZN?=
 =?utf-8?B?dEJ6cUg1SXJFSDJEUVpJTmFvOGZIcWVyaS83ajZRMHMzaWdvelBQeS8rb2NB?=
 =?utf-8?B?cWxRS2dDZUt0aTJLcXV6ZmQ2ZmlqbTNac21mU2c5TDJvMCtLM2YyNWJLMDMx?=
 =?utf-8?B?Z29SanFGaE1obTBaNlNvUTE3bVB4QkpjR0IyYk1NK1h4eWxEa3ZGTlZOVU81?=
 =?utf-8?B?M3k1QVhlNHdCckx3ZGJoVVUyU2N1dm1DZ1hiSmg3L2ZxbUZnUXFybFRubWlY?=
 =?utf-8?B?RHJVYmh3TnNxOWdRWXRKYTJQbU14SFVnRXg5SWtqcXIvSkY0bmJlU0txS2FY?=
 =?utf-8?B?cW8rNnpjUnY3U1lwN3dRNnZUNTg0UklCMmZ4bUpheXVWa283WkFpRnFBU3hj?=
 =?utf-8?B?NUNFWjNRZDRwRm9tVG1xWi9iSkJvcE04TmxqWkJrWXgxQk5EM1lObkxuZ3hh?=
 =?utf-8?B?TzR3TVAzR3U3bmtLOTkzZTIyU0hET2E4enhUVTNZTkdvQ1NnbWJZUWE2MjZD?=
 =?utf-8?B?ak83UU1TQzdxSnlVVzYvVGJEUW1oZEVudlROeHhnV3lQQjBKa1dMWk83aVFX?=
 =?utf-8?B?N25pNnJTYVQ3QzEyVWM3aVFucFQvUktYOVNZR3NXOThGSEJXT3A4STZrbjQ2?=
 =?utf-8?B?bFdldWM1VWdSM3BTcFczOGoySVY3bi9LeW5ZYzg1VFRvRWdBSi9kRm81MkFH?=
 =?utf-8?B?V1QyWEcxSzQ5QmxVdldweE8wK2hvdGNlQzVtTDNBajRnUnBjbkZkbFd0RVRB?=
 =?utf-8?B?RnNpZ3ZyVUF6cWM1Y2ZJZEFnYVUrcU9pbVplcFZhT1RLc1JoZ0ptTER0aWwr?=
 =?utf-8?B?STJ1bU9IMWthWEtydFhjRmFhdEtHNjZ6dHBiQm5EYk1MMmM4L0I1VHFYMGFs?=
 =?utf-8?B?dGpGQnl1cTh2VGIzT2o2RGx4L3h4c2Jyd0dmbmNyVnNXaS94UW1TTTZsY0ZQ?=
 =?utf-8?B?bWU0U0JLZHNDQ0IrOHdsODJmR0FlUWJQOHdUNVdkUHg4ZUttM25obW5pM1ZC?=
 =?utf-8?B?UVZkQ2xJR21GMS84cG43Z1FIREZDNWo1UWxjekVzN3BuWWhERXcybFlPQmhX?=
 =?utf-8?B?dHZpbUQrZjdqeS9acUhBUUwxbFFpTU1ZR0wrVWpZVXBTam9kL2JPSDJzMWNy?=
 =?utf-8?B?QnhhazBWN2dQWENPMXBWSDdTdS9rRTA2RDhVVTR5RlJTRHk0anVTS0ZwY2gx?=
 =?utf-8?B?VVM4MkZ3Z2xsY2o5b3hubTNuWlVwQVJCTlVKR2JxU3hnVVBQY2RkeDFaWFBx?=
 =?utf-8?B?U1d3czFybVlOalc0akt0RXVIdndCS0MwZS9YblVEOGs5MllKb1c0Wnc2OUE1?=
 =?utf-8?B?Y1QzaEEwWW9XdEltN3YzSUE0OWYzakZkUy9LWmI1MWdLdXhaM0VRSE8rTnhP?=
 =?utf-8?B?a1l1UjZEUlE1eGltOGcydVJMeVFxaGQ0NW95anN4NmpFczNjK0JkS3F1WmU0?=
 =?utf-8?B?SXEyeFNFdGRpUHBHQkZBVzIyN21tbjBZUDUzUElQMi9FblM5V0tyUUFuTHdy?=
 =?utf-8?B?NnArMXN3OTAvYTZyOHVuTXZ6VjJCM2VYNjJuRmluTDZCaGlqcVN3cHVqbXFk?=
 =?utf-8?B?NDliWHZHdnB2ajVhUVRlZWpJSFJpOUh0UWRFeG5JcjlZYllGMk1sa1NJVExa?=
 =?utf-8?B?U1N0dlNmYWNnN3Q5NXJEZ0pYd2RNaVhzYTVlTGF4Q3BkdDNDK1U2a2R1K3Nw?=
 =?utf-8?B?Ty9CS0tEYnlSdFVBcVh3VTFWSlA4ajJxaytaUjRLN0Nwemg4TVR4bXlTT1N0?=
 =?utf-8?B?c3pKSURQQ01hSWdZb1EvYk9DRWhqUG5VQzhqRmhQM2VoTTFQM3NObWpzVE5J?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069e51f-ee40-4412-0ee9-08de04ece3c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:27:41.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2zmrLOvSkgpbpNYC39Y+H5/HDPfVijhufSA2k7NgJhCQMoSdGGiYe0WRC6mjUb/qfF79VPDvqlxCTHqc4sW8rxILHTdwjjdzQN3apc1Nwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9515
X-OriginatorOrg: intel.com

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:10 -0700

> For idpf:
> Milena fixes a memory leak in the idpf reset logic when the driver resets
> with an outstanding Tx timestamp.
> 
> Emil fixes a race condition in idpf_vport_stop() by using
> test_and_clear_bit() to ensure we execute idpf_vport_stop() once.
Patches 2-3 (at least) triggered a good bunch of compiler errors in
Tony's queue due to that XDP and XSk support for idpf went into net-next
already, but these patches weren't rebased and retested after that.

Thanks,
Olek

