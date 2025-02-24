Return-Path: <stable+bounces-118720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321EA4193E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400907A184A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE613244195;
	Mon, 24 Feb 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMcZNRfQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B0243370;
	Mon, 24 Feb 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389539; cv=fail; b=n6ahtuzddANVb7HMHWOHbvIZ/NCcIt7pfGk4XyL7i6S8KB27qedhfLdqyj5b3cpSsHumZ1EOEz6VeyZDw3OxRknga6BarHXXzXsGRkSW26MHLrzMEsOsEyTzk7V+L11bm5dWTIlhuV0RKiwajEfk2cCeuejLQ2WN4GiB8QxVS7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389539; c=relaxed/simple;
	bh=2Zf6CSo/waSMMjg6gOHDAvDN3w06du9k8MEVJv/z40s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IpNwKeU2A3pLDfTs3shGZZO+KLE7fvSb/Ecn2c7yPqTiw/yX4gvATBQIukdqLIXtHzc0ZqkWKFxbbBZ67UxsVYAIuyP0gqs4UPwt0LPITd/uNSXdZX+a4qXGxbRbXGwi2iIEUeLWuYuEoxqvL043ne/tirF8WB69tbt4dWUhW8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMcZNRfQ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740389538; x=1771925538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Zf6CSo/waSMMjg6gOHDAvDN3w06du9k8MEVJv/z40s=;
  b=eMcZNRfQkoJjuLFBIeoKW3SSL/xqxLwXlRZtOxK/z+PIX0i2mj5KQTzr
   OTmn52ouBnBNkVTIBlwQSOMdaRss9iM/XUp0tvwTw9BxL4Q283wXexvuF
   yeD85+qfMsfBoAT2Ww7a1pJXoDW1z9lTAsYegnRMILODwzg+PfMKUxb2C
   tzmbLuxEsD2zMhxqpo6omf9YdSBj+pNXzGhNj30uWXQKyNxkzPzkVV8hK
   k7vIeq5HsG1KuJdfaxBinjDa7ncW6ZXt5N2bbNEikebNpJU8o/SzjIMiJ
   9IklkVVvGqQb82iWoAYh0vgUUZerIMCzEC8dvcIAEtfX/d2lADcqm/7hZ
   A==;
X-CSE-ConnectionGUID: z5zfXIOrT06OywjoYqLWLw==
X-CSE-MsgGUID: pcU0D8FeQdqWmtXJc1oiUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44913358"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44913358"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 01:32:17 -0800
X-CSE-ConnectionGUID: SPXo2UeIRayXDvkdacCPYA==
X-CSE-MsgGUID: urrj859RQ52K4HN5nf21Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120131621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 01:32:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 01:32:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 01:32:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 01:32:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqIi9ugB2c9rETQWphosmgEiPLOIny445+v2E5KkNdkQ+3U4l2nyuNcxqQ0unV9kd2EcSEV0X7NGVD4bcoWbLei1PrUKbrRF74SHguMW7xcqsba//S8peTqXU06i9chyxabZ+3bYR472hxpzdkNQoOComgz1Sh0ifZE0DM/Sd/ipZPfl1el8SL0sNBJNd9Zq8fge6Grl0TWlKFlFlXnSZQBDxP7yTzA7sZnf+AHYXN7jMhnKQX+251wj4bukFRcM+sPnKx4TzVpvekIozVnULtYhPN1iaBzYfKxxkTxIq8gySPr/xUYkILjJM/bX3bOdtWIAL0OIWrr7lakcIULQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8pCUZeztYy+d5GwsSemC32yg6Mb2ZERu4N9ff+j/5g=;
 b=l0hbdXk/L1AMosJxkhzPQaX2V9VhVKlKTVjuLxDX2VkOonFyGnNz/pFWg9MuIr4JwQBoUnhw7ArgPya4JuraTWRppWwHNusV0Q/RSf4NdtEedbaR5fjnWTCUCsGMOwgFlYgR+33WsLS5CQsH/Ja8h3Bt6TzVH8J0sIAN6sQ55GPGCPVL69zrxY9Kz6XlgTGxGSYNVC44b252sczJtNeFWVFdYQKbakRHtwZlWgNjQEK6AvN/udQfwz/Jk9KwFd48WnbpDZ0ZMPHpokuYWkQPW02YM50vBYE5f92747sssFeN71teAFet6HE9IUPWnyAY93lgpEIWno9FTdAAYbog6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 09:31:27 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:31:27 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "Glaza, Jan"
	<jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Thread-Topic: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Thread-Index: AQHbhi/zs7hnAFB/d0meSi67d6h7Z7NWKHbg
Date: Mon, 24 Feb 2025 09:31:27 +0000
Message-ID: <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB7318:EE_
x-ms-office365-filtering-correlation-id: 5067423e-eb41-401f-3b21-08dd54b6035e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8lfjPP8UZ8p95eRdUng0pB6jpaO+YP5dadrnLR1uxrNxDtKEYNGYxoEfdlkZ?=
 =?us-ascii?Q?by0tjI1v1Z40RKVD/Xhwzb6ycJfae83AZMafU4fOlujBz39o/addaZ1waOUt?=
 =?us-ascii?Q?0iorM2uoNehKHogb4/0C1zaGAAWaYvvr3pAVwstT9lkyE/1PAVH4/2YAWRM0?=
 =?us-ascii?Q?BW3rnsAtCzyTvODm6NDHK+dXCf7gni8ZP5JHEUAZhhEzluzgCYxYCuoiUz1g?=
 =?us-ascii?Q?YAZlYdgUoG7k0KTQYPqhzqUt6MX8VACVAEDAd1tGTOSFzj4UfohaWTc+jFvM?=
 =?us-ascii?Q?u6t5XOiVgm4OLbj6C/+OmAQvQ+C5aCdyCAwM+Dc1HPHT7aeD8p5TCjgAcUa1?=
 =?us-ascii?Q?2ESEqogUKfB9UhcvbF4Jj+16Dia7c+GR5w0uIC8qd2bUOQvwNl9CL/3ZAaj/?=
 =?us-ascii?Q?4ErSmlQjda5dQZOKyoAezoirE8PRC+zhBtVeRXN4AhnZl6V7PxT4dq7coMH7?=
 =?us-ascii?Q?PnndQEi9PDNaI0p97Zimne4x/BxHmXMCbwsEobDN3u9o1Aepw5poYF/E4F8Q?=
 =?us-ascii?Q?TVZ0VPbdXmcrcAcmlzWxyH+z8ZW49irb7AXmnC9CdBAKjr+tRBQ1NoLtdJ43?=
 =?us-ascii?Q?Cfo8St1h4awV8/wHdx3LtnnSOiVi9iZA+yClV/BR8R8GcVOt5dvhU7DVmTii?=
 =?us-ascii?Q?cMEx2+Yf3D5oPOGJ/DoYC8iOWPls+ZVDPkOslp41r0FQBmJxLck9g8ty/F0j?=
 =?us-ascii?Q?4rJzOg2HAyzQ5d5D7wc0t42xKTVNx3nf8II8ibnB+aKy2pD4hSO/yPOKsNrw?=
 =?us-ascii?Q?5vXoY9Jg1MRblzpOHp1SEVAZlFWaM0v+05I+6dw7KO7QiDy8HFVsSmYKLJom?=
 =?us-ascii?Q?BFf0NwwwNero420KgNwm/LPJbwnmq5u8omD2WvsaAOPyU3rZf55k/kQ9dsgW?=
 =?us-ascii?Q?A5jyhHb2W2BLss3uYaBzQjLmTERLjFxKYdv5CIbjiXEz5ubFUG6/Q/VVdgB0?=
 =?us-ascii?Q?4UTgbzzKs6lLA/6J3I/j+7cmtLh2xi98Wzw3wa+WWTN1IGa/sA2dqqErPs3Y?=
 =?us-ascii?Q?5Pf0q7riVJc8WyTYQGjlXzXXVEux/taVfhMX3cUHu4fnX0PUCcKTr6E/tEqu?=
 =?us-ascii?Q?kQTDwmdfYRJsP1xA1G8qO1up845Xg2iEbWu2tw8jQhe7VjtSTKGVQmH5tWmc?=
 =?us-ascii?Q?FC5/eGl4+VnILymZXzwbiFhcOnklonbRds3DWVUIDZUpgM20uvgrVPpmzKYH?=
 =?us-ascii?Q?hvjQMrD0xqYu4frnfKY/+yy/RpkWD0uHNdly6CJJMQAGyHpjkgNM96vW6URs?=
 =?us-ascii?Q?2IpBwDdrM/5xYY566lpAxHf2ETcyUT5IJFh7ScdCOVFiLuSUZ9bAVhxKh0Eb?=
 =?us-ascii?Q?AfdpXylbWmmknH32LAH5cG8NfoVNmq6YtMQjw/NZc+VGpTLd9TOd3SgrstrX?=
 =?us-ascii?Q?QRPyIPuxFuCJAepMKyWge35C9kjLtQh4faMyIi3LiWNgQ268nonGCQpHTDN8?=
 =?us-ascii?Q?zWu6VJtZv8InM2KTzdswZReA5jOt6m8K?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9qdoZX0TWmkD4B8tuvE+nXguoN9kRKmvEuXojNgYEq/JwMvY4fbFCldvSSj?=
 =?us-ascii?Q?LeiSqiUXnL2pETfrdSZA2NJcrgQ6RK4E/joXlfNUA/Hz7vDGakD1hrQsWmE5?=
 =?us-ascii?Q?/bXAs3BFSzHiXIkh2bv4W59751urEsgADtj6QBoBb9aSVyTEM9pS6CeWm3j3?=
 =?us-ascii?Q?4cJPxOdnosJMYq/13KqsstSi/bN22iFohe9zwxACQqiqqApesOG/i49VsT7Z?=
 =?us-ascii?Q?eDskiGEUzdlck0HSgjft2qOQR2xYY9ib0V1ofxo0It1+TeCfnO6zFvh8WpNG?=
 =?us-ascii?Q?RcxjyJPsPw7eCP/jVFQeolhjQpoGtlQHbwN5uSOBd1S5IlHsz6oaq4rX08pZ?=
 =?us-ascii?Q?0S28Bp20N86noAr0Gouf8x/idmX3j6nxaXDs+3qFzhZ2W/QYY0iD7Yux07mp?=
 =?us-ascii?Q?d5q+huq4OHxlpULhj6hEwWCeAmnTtEFwSbyiClpqSncKH8iOqJ7EE4RNWsHo?=
 =?us-ascii?Q?h4Jp7i/IfmvsVB0DHeJcBYiSTW6gOHAdjg2l8GbP9pxWnopE+TQHZDEGTEdE?=
 =?us-ascii?Q?5hy5Y1KqUCXHHSF2yTj1oFqMyUuMmao2TotlSDJEp3I/RaXcbPvq/CZ6A9qe?=
 =?us-ascii?Q?ebtLYx9HA0XddAJ/hcS+NGgKFdfcNLdrb2HwRVVx0qLN4Gb+UwEXMYURrXOQ?=
 =?us-ascii?Q?6SyyCsp8r0Yvvay02SsN9cHn1Uqq9XfVi/bzPfjL6RVTmZbYv4d18PeQMx2a?=
 =?us-ascii?Q?fod4X5Me2/3gtjn419rU00gfsOiIHIVJF4x9m8kXkBLtb5IWVF55fOS4wNJF?=
 =?us-ascii?Q?gZLUDK3De8aXE8rvcFllwJbIzr1zSm0pSWFGfBW6MlbKzuEBykaIGEQ9M8IO?=
 =?us-ascii?Q?mPNCAAxZdNrm+MnPtNnX2MhoZOiLDLaoWRtNc3RrNUSibrQNR4Li6n4q9n3b?=
 =?us-ascii?Q?Yon5qD6sP+LdgEEaVoAUfnyrTJEZ4K5b6RdRxGTjkAtNTCuyNug3ogQ2jHKb?=
 =?us-ascii?Q?LYOD9XARhqzpFkhAHZlPhJMrEe8MFCf+Bn7IDMbzcLkbYwR98B0OAYYUE5MJ?=
 =?us-ascii?Q?A5/GPAEJXMNszfnroNS7lZf3T6QZROH4IyvTf/+fbcbKpD6B8vfV3SxUECfl?=
 =?us-ascii?Q?EXaZ/AHWdzfZRrTpOA5rGDg03HpOacaHnSQ1630BdxFBO8Ed3q9CswVZwHYK?=
 =?us-ascii?Q?5DRMkrPmXj/V574t04BlLkFvCF9qempat4oop2eveu9aEMPeoLBlQ7aNFoEe?=
 =?us-ascii?Q?7yrpZ/j3zb3fH1TWb1XN0zmbogdo9RJBNcsKb83z2jzhz7kb1xBiPj6XwLWK?=
 =?us-ascii?Q?GlZe/km59aIPYkqjxIvrIHxkifs/FFRjLibiLLsFg+n6/+pa+30dO+P6bmKU?=
 =?us-ascii?Q?abxS8ckEWymffpYHDpoqCxUhIf4px3OhypM/zRXNH2hS51pz4g3MbSOAMyRO?=
 =?us-ascii?Q?M8vBUqtwIf5zPaoQAvEntNSPp4C7tSdhzs8DssSxwc0THR63jt45T5RzowBa?=
 =?us-ascii?Q?OXhGXOjbFGm66zWEGJp2NrvKWJ2GMkL6Easv+yQBwIH33Eq5QlYwX3PTL4dW?=
 =?us-ascii?Q?73X/IQN2hW9dgjYHPe4V8REFz8ZWW1dbK//0eW7+hmws3LgQVjZ90vBEmEHm?=
 =?us-ascii?Q?v8ToXLK+Ox9eXu7Iw31Li0Exq4UQytHBYi29sDSmPK+5u/2iGMsujzKyFv5/?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5067423e-eb41-401f-3b21-08dd54b6035e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 09:31:27.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J5Hqt0zCTLD12fbsD83zdrEdYK2Mw1zt+PYNCVaU4EKEa2ORApM6+RJn8zmc4G4D0/LaxFPyEPwtwwUBPxP94VqLEr1UlecxMdhP5h37Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-OriginatorOrg: intel.com

Hi Jiasheng, many thanks for the patch!

>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>Sent: Sunday, February 23, 2025 9:17 PM
>
>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>dst->freq_supported is equal to src->freq_supported.
>In this case, if the subsequent kstrdup() fails, src->freq_supported may

The src->freq_supported is not being freed in this function,
you ment dst->freq_supported?
But also it is not true.
dst->freq_supported is being freed already, this patch adds only additional
condition over it..
From kfree doc: "If @object is NULL, no operation is performed.".

>be freed without being set to NULL, potentially leading to a
>use-after-free or double-free error.
>

kfree does not set to NULL from what I know. How would it lead to
use-after-free/double-free?
Why the one would use the memory after the function returns -ENOMEM?

I don't think this patch is needed or resolves anything.

Thank you!
Arkadiusz

>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>Cc: <stable@vger.kernel.org> # v6.8+
>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>---
> drivers/dpll/dpll_core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 32019dc33cca..7d147adf8455 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>dpll_pin_properties *src,
> err_panel_label:
> 	kfree(dst->board_label);
> err_board_label:
>-	kfree(dst->freq_supported);
>+	if (src->freq_supported_num)
>+		kfree(dst->freq_supported);
> 	return -ENOMEM;
> }
>
>--
>2.25.1


