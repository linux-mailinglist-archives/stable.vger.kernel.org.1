Return-Path: <stable+bounces-237893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LjmGRNQ3mkrqQkAu9opvQ
	(envelope-from <stable+bounces-237893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:32:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A53FB4AD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3088B3027E70
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A43E8C5B;
	Tue, 14 Apr 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rz91Ky5j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD08F49;
	Tue, 14 Apr 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176992; cv=fail; b=LFxXQOatGREa4DPX8QhcmycWqtY0GZtNn2BGgaXrd/TwiUekN5MsHkbJTfxuFaqomtqn1OnHKolbe4ljjnAhP+yifP430yVg6yVVKWeIytGTnQmJDj2vYJorf/GybQTzo0azRsHiPnfg9CmJmcOmeW8Ib34pABhuphDoals9ABM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176992; c=relaxed/simple;
	bh=LRqSxq6L8IcGINi4p8qwMsiSb46NTltQQ7M+SeRUvyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqJ+gjL0MfHuf9RFcVZHV8EK4k7ysYqHGgNgr1uD9nH7temae3C5v0YTaGkfxcpLJYyyVEO7RccfdDjVEfXMFLptLkf3F6xMelEhpjYlc0i+V9UE17PqvCb8pHEpbHVBTzs6zJcMmHWi2SjohoePT9uEQZX+WkvmOwMbTYxuHGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rz91Ky5j; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776176992; x=1807712992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LRqSxq6L8IcGINi4p8qwMsiSb46NTltQQ7M+SeRUvyU=;
  b=Rz91Ky5jMeZlosJFNlIeeUZ9yzn3jTFY1Lknt982vaPvW9q7Gj72eKYS
   RzFHz4gW34eu8yacidheOGRZgL6NWHQ1aWrpAGvew5Jf6tjh/ZcWjPoqH
   LKQa6tk6sG+K2KrpIlOTVntfOr/LZGzgS04aQhxtMtmlnszx82iUIY+DK
   ilQeKtno0IsSr5DN6eeUpbtH2ILmLl4/P2HUeAN5JjG9v/CsZt9Gwm12v
   Ahi9Uwst1EQNuo0kvt5cLU/iFdbkrZnhmzX00uJ7brxrrz/VxHFrscLUk
   VhqpziFG4u+jxsxS4MOTbQNDxoqQYaD0InIh5BCl0mcfFh8HpTorbB8cl
   g==;
X-CSE-ConnectionGUID: bDfHQ/VbSRyzjZfWy1yDuA==
X-CSE-MsgGUID: IDQLEewEQ6mdG3r496oWqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94535413"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94535413"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:29:51 -0700
X-CSE-ConnectionGUID: fCV1F4NbQPSQuYuEie1glw==
X-CSE-MsgGUID: YXp/7CvaQ9u0FbfpBCfeyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235068311"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:29:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 07:29:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 07:29:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 07:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0Wb2CA9UmRpIdjPK6kDDd2xIwZr+ka0yok8qsr+fg4o3tdnvda/sfu80SkOG5acYzHD8D9lX5dDFZTkotx0lLNXnPQ07e6huaobAtymuYRcrwWbQFjoeuhIRb6sd2YL2BUVY3/I9MBQrEVNN/GHLrcPNrJ4pmlUrH559cDj8ACTSSFWzkR7/KOHasuo3GJOvuLiOlYSwn1FFLy+tn/962+N5FB5loNOghBlenhumYRi5ZgttUemy5ZEufci0B0KTo64+8a7ysqtL73NOCcHqPJu2usZ90MWPtvb7JKUMDRgTRwH06IKUrwPoe7rWyKLAEExQBbmWLL1hBY523qFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxPTRwKSAdrxlkcDZFxr9Ps+omzYhzXOWllX4LkVx1w=;
 b=HH5gU7wY/+TVJruODhrSPA7hdFfDYQA8llXyxp84+pjFBGZZWogJWDFvjl5FW+K2E3rHWqQ+gontHOjTy5bTgt9AC7bReeQjRPCWc2WY01WGeUgCfPZXscYdaRbX4ckTNSOQuH7TcBM2N15oMMKHv3Os9yv9GXu+3EXeqeXTY4AKm6JmUnL3OQ1br9kBIqy6ApleqaB4AD8FOm72ylwjvJOafhkbIREfibAnzo+Pv5Xvr8CWJ5VBbmRmx6sId0rf4Uzo5zLtFnuwiH9l8USm4zEoXB0GOVeZEcaIKVRGytyXTd7+cpM6pJgrsLI1MeKbLv/EcsWC3bxEz+1hdfQVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LVUPR11MB9590.namprd11.prod.outlook.com (2603:10b6:408:3a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:29:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 14:29:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vasiliy Khoruzhick <vasilykh@arista.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: don't fail probing if ADXL is missing
Thread-Topic: [PATCH] EDAC/i10nm: don't fail probing if ADXL is missing
Thread-Index: AQHcy5tTXf1+vUXOhEmAIhESG5Qv6LXelr4g
Date: Tue, 14 Apr 2026 14:29:42 +0000
Message-ID: <CY8PR11MB7134562ABF0AF275999ECDAA89252@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260413231413.73987-1-anarsoul@gmail.com>
In-Reply-To: <20260413231413.73987-1-anarsoul@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LVUPR11MB9590:EE_
x-ms-office365-filtering-correlation-id: a605c4af-ca44-428a-656b-08de9a3244d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 79ZTMThWdxnB9TEMb4Kbg10GCrJNuwmaRUaJ3T+dxgkRAfuBGqsN+yI4SVGJYAWKfM2c2rIutaeQKXDlQ7YrHT+5wuonQxqfC3anXNtzkqpukP4KEAjrS4H+k4w7xaD64NF+fPVaRisdzIJzCTZ3lWVeY6qb1h/PLgIX8LLCulZak9f50CJU+ZUTDtZmgyw3vzM1UbGF7GLd3gMcsVjkG6OriAQ4aC4U8YaeCFWREe7t9loq9FrFlltm+/Jla/bwSKiCIf2QZDVxwd7QzWKP89+VNt6PIvjOFkzL6ZV6J3ug2qJDSWv927viEK4yoVcJmLhjD62FwaAKattuOcQVuWBoWq3fh3QxrpbzuZCUvtgolWoGHfXQ5+2x8BQE+CxC4fk41CJZHOteUtUfmMB3AaBaRiEAOi7e0ZNgih9G7VMTnG1V7GHWv1jqZl8c3AGTCiC8bUzfpxiP5xBrBvUDQwsEMhYJdwTCkAMJJBrJDn0a9NWxdLqaeqT7kytEt8iLEls7CjPuhe2HljsbGqj0cMUPorVIPw8P4pu17rVodVq6t7wKYEgEdrvGt1MXAEoVLICaRHAzoScEA9/raj9tBFEXzbfwuH7vSlY499Cv3iN4lrqZrC2visx69EApxKYNiJAkHA6eCrk+54PNNlGN3fxJbbBNw+kxoU+CQVSMz3lsEORSIFNVXczp8dXO/roebryQRHlodWPUWF47Jd/cu4wj7qvD7TqCbvnS2dA6R4JcA0hQzwfp//uLgo1BLQtwt9e/x1GFUE4CCrd8gIGJKtr4raBqBpjJTQFm3UJ4Dc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1VkTDKOlKgsrrbY+ui+g8fUFWWsxghOvyCvvW8C9XTLxznFwF+zFCp1+hq+z?=
 =?us-ascii?Q?3JLfJmOJCtf9jYkvn4mFsg5Bkd5xRD/tqXWT31J2DDUYoBONxNHA7MR6x/z8?=
 =?us-ascii?Q?5cBvz2hFzbFvhYKN61mbe+Fnd2fUWVv4s3sPnxETlyRlyrLUrtlAF6DOaxvz?=
 =?us-ascii?Q?vl+nR8hFmJMuukY+XYNfJXJyg1RYQArOrHoWvoqBfIv/zlTa1PbnrDazyDKK?=
 =?us-ascii?Q?iw1UfelS9hhpylT2Avv/Dnamp4S8WfYZnN2X+raVsOnqlikhx7bIr1bivrOT?=
 =?us-ascii?Q?JEXrRrmuLz88kMQRPA/qh+PtRFsIc4JJWvFXrVMhD7XBshLE3rvBjCETl1N0?=
 =?us-ascii?Q?ldR3f7TDI2EX3OP9qnfVBG5AgotYEU/Dw5nsubSJ1NB3zqScbV63mvVDsGMJ?=
 =?us-ascii?Q?2NBEIxNLskb/BXIdczMqY52mmPq2sj6jaBQNbAO4v/nSXmE3QvxEtYuGq+I1?=
 =?us-ascii?Q?h53WYzQCb1kz8VaEof5zUBmRagJSXixVRBxcKqzDlwof+J42vElHRWex/Fa5?=
 =?us-ascii?Q?YDgntUUWUg4R5q0fxRbaCuoemtgqfN161SRsfgE11w80ECKG0CLbFPl7oGTD?=
 =?us-ascii?Q?Eu4SLPagr4wS9xjPMHLVgUF2mi2jm3/nbvzplY72U5RGhTSXBe38crbU88h2?=
 =?us-ascii?Q?UfyXIYPeGYr+n9lbSbwTaUJyUx58E/uPNYKJXrATCbbuzbT7Ozr2cJQHiUHV?=
 =?us-ascii?Q?wD4j3ifHwOMTBcLNtXYJcIQcytST7uQwX38uJvdQO/hAuBDJjkXXeqYj/CbF?=
 =?us-ascii?Q?q57xUGd5heia4ubXNUV20opJ6Mo2HeHpL4+abfBiSnvZj3ikOE9QM4Ntm7r1?=
 =?us-ascii?Q?sf+JujQSdv3EVO/vrSZcfrMfzArEQZgcaaX/69EC2EHprYQm+nBBBly1LTyh?=
 =?us-ascii?Q?u3DA7dikWQ8lPtUX7zQUf8NNtJjrbxP49TfTB9eROKCPVS7f+xzz1DYFp9Gq?=
 =?us-ascii?Q?g+N6Bunu8WCf43GRhK1b5X112fegsLqDNKx0whqmhrBuNSwXinSFHY9iw0Kk?=
 =?us-ascii?Q?ioKpGrusBf4Ik0vxZoG3UB5GCBuXd2ckPvYFL//HESJwwB8Em5IOacNCKeMU?=
 =?us-ascii?Q?FL6t22otST6RVs+KmIO1uIY7GcbRJw60UvOgUSqHZ4P0UV7o65MuWkHMHncB?=
 =?us-ascii?Q?h8cRxy6Lzy5eBHNGjV+EjeRevAt4BPJZ8ufpDYJ8VwAFcOCaGZvTkLR07uXM?=
 =?us-ascii?Q?jTe0y304dUXUVwzpm9JHduQtR4vI8Hjc/qDZ1r+ob4JBzP8ocoNmdNcrRwoP?=
 =?us-ascii?Q?ky+xb9lBkOcADFohkdc8POIwYfw9T082z+HmkdIi/sGwTFeJScM+uIJg9uy+?=
 =?us-ascii?Q?A1yl/M/BKyAbYiEGj3lR18h1dHhfrgR5DaL30nJeh9TfjlGbyb0yKbO1b1Yc?=
 =?us-ascii?Q?sWRHY4AbOo0umrEN7tg8SFCnYAxdcXb9WbMCsBOV24uNv9UDrwZghtZ3uG6I?=
 =?us-ascii?Q?00PRX3ClSn0BcbBazvvxYTWhBNQ4CeO7vSKZMSDDtU6oFj1zbdgNtCqdYUQ9?=
 =?us-ascii?Q?7pWm0d27ZFCURbuPY+Hcp4K1FAYll9p5tD5YfZFvi7ogC41nO3OFKfSYmb2/?=
 =?us-ascii?Q?sYfJ8fC42hM1URT1VZKuCI/qU+9DXJhUaSlZVI5zr+sJrNCGeoChjbW+KvSq?=
 =?us-ascii?Q?VWisAyr3zhCDr+Cfs3t+Gwjn9EPv0w5FyMS+Ye/1sNS/8q9QkPDeHGuOyA+a?=
 =?us-ascii?Q?NlOHzglaFADag+A01m0pyE6nHg4P2di4ExA5kUpq1Qgd+3JbutRW3IF8L4c5?=
 =?us-ascii?Q?tWL4NjOS0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CBJv8vO/X+m5GaIiG23LXgpzY1udN6IMxmOQmHZ9zCF2smtbk1kMFa56GRk5qAqdZpXiiGqG3hgBRGqNw2qXftyRlqgbeUzLMOdSCWUENJVzNy1CTj8RJXAhoJCUy8lz/+ymMP1IoQeijxD0DnBr8xWgMx5FrN/ARQWBoXegkckQbLrobBJ5TxVJzacawYooRbiEyKXDND/YjY9E5TgXAeWZTJ5UHs7K12F5VIc1wcSWb4GxkA4DCMZg5LQ3Xz8kQWQnnGl2tBlanKDUOFUBk5uE+zOvxJ52yRbaeMTm4ngifR++4xkQ4b4y5en0OWnTegVvz9foVwll62oCVIFuVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a605c4af-ca44-428a-656b-08de9a3244d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 14:29:42.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaOa+pF61jSSY0xZESQ84nQ/wEVi5FRM5WvPddhXv6It6xX/qV6jOcvizdMFBQS0vHC4CSfNxiwAPGa7KAlOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9590
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,alien8.de:email,arista.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,CY8PR11MB7134.namprd11.prod.outlook.com:mid];
	TAGGED_FROM(0.00)[bounces-237893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,alien8.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qiuxu.zhuo@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 664A53FB4AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Sent: Tuesday, April 14, 2026 7:14 AM
> To: Luck, Tony <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; lin=
ux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Vasiliy Khoruzhick <vasilykh@arista.com>; stable@vger.kernel.org
> Subject: [PATCH] EDAC/i10nm: don't fail probing if ADXL is missing

s/don't/Don't/
=20
> From: Vasily Khoruzhick <vasilykh@arista.com>
>=20
> ADXL is not present in Coreboot- or Slimbootloader-based BIOSes and as
> result, the driver fails to probe there.
>=20
> i10nm does not require ADXL for decoding errors since commit

ADXL provides more detailed decoded results than the driver decoder.=20
It's the preferred method when decoding performance is not a concern.=20

> 2738c69a8813 ("EDAC/i10nm: Add driver decoder for Ice Lake and Tremont
> CPUs"), so we can just switch to driver decoding when it's not present.
>

You could phrase this commit message like:

    Since commit 2738c69a8813 ("EDAC/i10nm: Add driver decoder for Ice Lake=
 and Tremont CPUs"),
    i10nm_edac supports driver decoder. Switch to driver decoding when ADXL=
 is not present.=20

Btw, please drop the personal pronoun 'we' and use the imperative tone.

> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>

Other than the comments above:

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[...]

