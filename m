Return-Path: <stable+bounces-244697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IFyNlac/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00B4F396A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE4D3300983A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B636403A;
	Fri,  8 May 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrEghvdw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093031F9BE;
	Fri,  8 May 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228273; cv=fail; b=jNrnJrRgvyhkP3URE9Yg8lJ3WYfx9uYSmYjOqD5MVBw9rc0yKweWQZNyQyytLLdAmpwtEj/pTLD8o1LSz38kJ8pxlHOykgbcZ499r66TYKEWDH45t323ECqYh0LFGRH6INTcybVtIvORVyYukuLUkTSjjhkEBdsuY+I9Lj/Gsow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228273; c=relaxed/simple;
	bh=om0MHlCkh7OV66vCXvaNWRZeOrZ11xbUIu3a6B0STgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3msaKCW+2KdOvQuJ3w2i3s+GqKxb+0fvvwXKXl8HL/KeUs9Ykp1ItNcBdB2+P4kqZmpKHear/dCqulyj1h/La+MjhvWAVUJqyuz7F2jO5CIdUHShzFn6CROyOyiZ/RNS6N7SE+V2NXHWj758fE8USq1d8hmaMcXKxY1sGbaoKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrEghvdw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228272; x=1809764272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=om0MHlCkh7OV66vCXvaNWRZeOrZ11xbUIu3a6B0STgI=;
  b=RrEghvdw60tw/YTNKk/EPqDx7egWnb+t2s/wxDt+Sizx853HeQudwDnn
   hpO8Df6hR6X811wneLaao7SBhg6o/q0kNkT7hxCAqPrgxpEJ94emxYJ3L
   QwXgFL9nuad1Fy5DaIREGmH+qXzGTHlxAAgTMHeCj/H1OYu+TyqE5J2Sj
   T4hFEgtDGVgNGsae7LLsmLMm5hmWvVPeH5aLgNfLPrPloPeqS4qh5TFY6
   TfC61vNFdw/ip7bd8t44iO40UpP6b5ziRMYxmRDwFSXsFvlti7lupoxeQ
   i13atAGHpMUYmnGMwex5AsFx6ClN9qaQZU1SinFO7cqZHMAPZN/cyCViA
   Q==;
X-CSE-ConnectionGUID: HtH6FNHZTN2Y2aJ/9YnFLg==
X-CSE-MsgGUID: rD70vZ3eQraJYRz+InohDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83063242"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83063242"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:17:51 -0700
X-CSE-ConnectionGUID: H8ZmhJDtSOe7d0mS96I+SA==
X-CSE-MsgGUID: P8cXShj1S2WKgPX3INzOeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232173790"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:17:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:17:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 01:17:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq4UOkOQDPJzvBtzC77Lr+OMEPu3Zvx/pHVeKdcjZBAtVGXpWLc101mH6BDOtFKE9j+3lbw6ZtLtaHLweWri7AQSC4ap15Cip81SyoCfLLWxTZoPMsiQQgQnUx1An9jeDZMmusFw7l1kJ5i4FBv+KphipptGWFK/ObfL6kv83jFAGLl3IIJ0ozi1sRrRZmH0HbUFoCAJ1qzLoPaYkN787dfOUteLxyIZdJ7yr0T5w8TjdgiL0vplX7x/kWLFUpLGivmF6rfBKFpS8yGTdtDAPhZFp+iaTQF23FGqSpSGNLegInT7uWmxYucAgToIPDi81iyqAvulMV8KRVAf6AYDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qrybuRpt1G50KRRu7ac5sWJysJD7/ORgleHUvP1a0c=;
 b=ab16ozzBQP//wXbo6artgHLgeNIIQpRHS4VLsx6kO5Drs0bm0+429hM528HpG8ArzsGIcgQuor+TcQewSNsbmhEvgeSWMqu5FEJOSLd+8zAYmU/TAdPuBNwcsj9w48VfHEFAr0gS7odXPQ4UEDZ3znKTzvrrJc0UQUbCWVA4+HBfRUgrj4fFX7+Cb962yNz+z/2tStskxN1imLK9FZR17K2NZ7EKqbBDt6/BMObBFpDBTyGJVgSyGCdjueKxw0AEHc/0xmDgDjGYJz6icc9+Oy+3d+FzxvSr3c5U06y1KxTN/8M5HJhoZo7FBc1yTphFTFyT5OH0PHRPH/M2eoXVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 08:17:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 08:17:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Kai Aizen <kai.aizen.dev@gmail.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Thread-Topic: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Thread-Index: AQHc2Mq8QFmsyUx3g0CJYnRhs8TvNbYD1I0A
Date: Fri, 8 May 2026 08:17:38 +0000
Message-ID: <BN9PR11MB5276AFF8FB5DF1C29C380E558C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7040:EE_
x-ms-office365-filtering-correlation-id: 66f80fee-b93b-4812-8094-08deacda4465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: PiiEf5el4nkSB/FlZzJCJKqrzr7WEbd3pvOYsh6IQuxDetOCAQqlOnGNLnz07OTOWPbbgHFdXU2y35yhs9nDK2kW1TPzViRWNHXqXkeOh1musEnei795Cs/nsIabHbnsaqMTK6zeVHlY1PmexHZCJ4N31M4D+WRQY/RPGYRvzqCibzT0G27KL59ys3mR66gxuELIg2F8zaIQUsBWIpJR9+r4XmItLEvbwxz/gIZm1QCurepBbGZOq7fZLeJj9qnzzJ4wrw+J/4KOLaBCAd6J6m21kpZy/bZKcff1nA3GOSZPsG5TUvxows3P3UPJ5KiWEmNdTV/NQPpzi7N48uzDaWFa9Hg8zLKdJydQO5gE4h4GFKD2S9/CmQdtd/jHT+YhyPLb+ek3WnmIU390oQ67A3YSLp5AbWFMgYf5fZBz2ncOtKSOECpLHoGa+K+Zf1bIBLI89BWZHrMOpJKuAaA9fuKHYb8zdEzho28KX763OQg01IY+rSnR4Lk1Vm9k4lriGGwrydnzeuqL3Xn+1Rkx34Z0fg1+c8RaPFRDL5IbR15+wc09LLamxVGjhmPqIsI4r/oREBXcu56i5rKDDPwYM0Q5wZh3KalSXs0Ao0jKi/2enGife17SliG00I4qB5gFM4ZfnnzBZjNxOF67MkbiZjg4m/g05K4xjbAZg4b5N+MxUTGJPaWuqjLmtSNtejfJgJWJB8OkPA2zJjFkNN4DgjU4avHgLQFf7fynEqjSKTGbpAq7OlQkM6E3Ct8n9bOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kzWA70tnKmj4oQiD5E5m2MUmglx/m2PYtPjlM7WTk2ToWcxQ9imeqBkLsEhn?=
 =?us-ascii?Q?+2gU+j6ePW1sBsZJK119YpByP6sBRDtRMtDBb0cuMD+JouMIp2n+z+fKu8IH?=
 =?us-ascii?Q?wAr6n+awOvvt/A2QNp/KvCzi32ukaPwj+MyFys+aNYoJhMWR2e1DHT7Sa7qj?=
 =?us-ascii?Q?kZiP6ttx30fs2o0nY08RzizxSqp3umpd9e1/rDZ7Pc42MsPl411qyLWxfjqo?=
 =?us-ascii?Q?mjtFSvW0D+rEV1jP9qVuO5nLEJvY5Yra6xyOlifdBnxNyGpK/Bbg/48CPLMI?=
 =?us-ascii?Q?yEHP4JxYk2rN+KAse5oF0xOXvpiBE7JJW+Rwtr90M+N4Sw0ZOWW1F+qz5Kjg?=
 =?us-ascii?Q?S0TN264HbRuUo3Y5Yp8Gew+Mdq8O2YmUZOjgLjcqSiNJPlSqUjAEY9TBm8cu?=
 =?us-ascii?Q?MDjhLsfipzbimgd6F2DohKZYQYJPBhirqPyEYQkhgPWTTzs7/3En99hzxrR5?=
 =?us-ascii?Q?RgukWmU5Xn21vrLAV/gciAmVh3BkFO8s5m2s8/kOmC+9+pvF87PucbDAiCEK?=
 =?us-ascii?Q?1psGO8OIu0CwtnU0pbwldItuXI/zhRhz8lT637AtxuPcD3On/yeUmKOZNpc5?=
 =?us-ascii?Q?VkaQtIIO6WJyd0gIXD917EcCv+h6JkcOt90gaNJ6aurosEflHwVD/Mjf0fvr?=
 =?us-ascii?Q?+t7ZUOIcCs0sxzOgsHTK3bJuj8poXflxAiJAZBZyvy4mwxp8mOYNhn8VXjzZ?=
 =?us-ascii?Q?hxVt5jWhLk5SsWd3vbRlL+wbUqMF92ju+qVdG/48rtsUcyFn/+6rse+sm2xM?=
 =?us-ascii?Q?EaXO4NgifxWvNVIP9tOrg/vR/cBmqo19oVABr3YAIqBmMjB8uYlI65e4tO37?=
 =?us-ascii?Q?jSsA9I0kBBE06sZIrcamRW/pFZK8MolFclCITkOIqSxPlfVwpnccn/QAu412?=
 =?us-ascii?Q?VkkiObU4OG5g4WdHYJxEj/7YjhNGHhcreG5hnGZhh18OCkL2JMbjmusd/czz?=
 =?us-ascii?Q?X5SawDJ1IcNV1HD4CDTUDGRNfOKRUPAVtRFZefzjQ2dF43hqpcJhExDTRV9r?=
 =?us-ascii?Q?Ap3HVVlA145zBsBhtSSMmh42C31ohIV96b7lDwC2HWM6aaS4SeQQFPfcRrWJ?=
 =?us-ascii?Q?4mAWNrmHnKd3YQ68nnrEbDq1N8jxeKJwYtzi9aVH9Hl8Tr52chsN3WXaZyVA?=
 =?us-ascii?Q?qenvDkTnd0mzAi0+qnVv2mdWnCPibj5d8Q1rEHaAmcqcLlutEPEOHwvC4Y2j?=
 =?us-ascii?Q?Gs4BTMFC/l8ks0l5AlQmpv+XLUZLBkytmkdKJUfl9/7i7p5GN4c2DGlbQTj9?=
 =?us-ascii?Q?cb43D9ex5UR4PS/LhaS2XoGh7lSjCly5Ai57cIbVElRvM6qw1cb82OqwAbbC?=
 =?us-ascii?Q?jvKzewI97fq7kihTW5ByMQOb11MIm2IPGPGwxkOeHNE64V4lfJaRfeCrny1s?=
 =?us-ascii?Q?T1Vri9M0qC/qeEC1PiCbGGtN6OaZECjpvehiVWQyjpxslh0tS91yp8woFGIG?=
 =?us-ascii?Q?h7BRg1/WFlq3XyO8O7xI0JMtKjq8N0DmjInl6Iluyxl8N9MOg/jGIfEF5RUn?=
 =?us-ascii?Q?g2MiHGB09xAwY94q1xnWLNq7b/NJ0SZvcIZBYHSQqm2h/pofrCj+CJ799G9D?=
 =?us-ascii?Q?8cGtQUR1yWPyLxxLIOwVUlPT5qd31GOpAPuZBIEDzrqH1QmI08oWlV6fTlOP?=
 =?us-ascii?Q?5T4giBkComEa9QyQd0ogvZCM4pCSSvsGzcy/YZrH79fW2HNC1s0WaIED6OiO?=
 =?us-ascii?Q?s/8DI//yNghgzpirELoh/+Vur9S/xlakQu9YzLmBRwtqdg+f5OoDPFkMW+2T?=
 =?us-ascii?Q?UdYPYcq8cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e9d2II8+JlZH9ImbUPp5YT203QHFzGekjwUoF46UpGSkKPPs/9ycU/wEE1Wnz1oTEfu0Le3bO8uXKC3EzBg0S+2Xro0qSVBDEjxfZlcB0mSqCMdZjBAvTgO9u1WvWC48wYM6TwKrOj3X4E5BhkuyioPegTUcpbPMpvbY3xV1atzoDcDc+MM9Ftw7LEzMIoe/k7LVGcgiUyUsTKbau4uU7N3Of+Zr8fCZGRvB5rn+6XfrZ9px2diGuGu3IxwgDvQBmXKFLDXxDIRNAsYZ5I0nb3KjjX7Xc3C97BmoqSSDV/0UxzJGuL6NCCTQyARhaZobHpCVaRTnuVxJHRxXNsRQ0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f80fee-b93b-4812-8094-08deacda4465
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 08:17:38.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ID2MMzhsq9XA00ULNYnWn4XXnLowTz970e0YDcQ6bJetd/6nuQp24jBsMZwbG4/F5X6rRJjaoqUck0bHCYXbDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DD00B4F396A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244697-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> From: Kai Aizen <kai.aizen.dev@gmail.com>
> Sent: Friday, May 1, 2026 1:57 AM
>=20
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
>=20
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
>=20
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
>=20
> 	if (done >=3D count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done +=3D sizeof(*hdr);
>=20
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) =3D=3D 8) the two
> expressions happen to be equal and the check works as intended.
>=20
> On 32-bit (sizeof(void *) =3D=3D 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
>=20
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
>=20
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
>=20
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
> IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

