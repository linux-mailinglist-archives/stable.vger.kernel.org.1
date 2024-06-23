Return-Path: <stable+bounces-54893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED219139AA
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AF1F220DB
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF612E1DE;
	Sun, 23 Jun 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFshbnwc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E325944E;
	Sun, 23 Jun 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719139709; cv=fail; b=VpK2Z/s60SF2fpzRvbLsWcXZGuvudqmEro+gLJY3WgVXa38PYaT/5n/8Iex8Z7MllI2naH2XRGOp4uO2DL0rCa5mlCdDaO2OgbR39m2BIk2n6MKe6YITcaEuqO/Gmk4SqtoRO2a3ubJUJ/QMPiCZTC9VCdhWtGfCaYxvKu9EPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719139709; c=relaxed/simple;
	bh=ty5AWN5iBYgKs+PvgRjGlQLdbFdgqzVFsLvu1E23ANM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hIkbXnZcELICpC+AiH4C35wJ+qFRAycXDOXlaKkm7AcTqdGKi1hYzOUley5+9OFK8KDG+PR/0FxaNtWnu2XeRvqolWWi2Hh022drdZYQalMMJylrKUySRe2DsDYgXAXYyuY1JHLEHzsaPTNOq+lRNcCIsBgt6SwmT+vVK7if95U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFshbnwc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719139707; x=1750675707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ty5AWN5iBYgKs+PvgRjGlQLdbFdgqzVFsLvu1E23ANM=;
  b=ZFshbnwc7rlhldpSrbPxywcLZOom1Ie7R9RzMWOkwEIw9DsHwfK3fRdn
   MnlMScLHgbYmpGnGbvApJlVpm93xJsinedhDkd8L06HOWeZqpG84IzmNw
   ak9hjNY+awlhylDvB+vcsz+46wzgeED1C0033UeazQdf7SCw2kGALORAC
   rWrRyid/PDMm/Wl5BNcn6Xu/+OKfidP6rz9EwNkwRqMewzh4RBQflHBPP
   KPNJ+YvuAtz5f+maKGpgHR2Lgw27dzBjtkFDSJfr9HK8K3E18y2Nxtp5Y
   hYxXEi/4JT43czWuApM/x1Rudv8un/CKDvTCNxsZrTR8q9Gi7xHIsQViM
   A==;
X-CSE-ConnectionGUID: G6v4nQHyTqy1lJ6FvxWiSQ==
X-CSE-MsgGUID: fRg54KwETAW6/g6wJCVWQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="38635916"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="38635916"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:48:27 -0700
X-CSE-ConnectionGUID: b48D1SGdS0GVdh5Fa8IsNQ==
X-CSE-MsgGUID: HO9MeHNlTMWn1c1gS7rPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="42893547"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jun 2024 03:48:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 03:48:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 03:48:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 23 Jun 2024 03:48:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 23 Jun 2024 03:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Law7CcWaZKwFrbZ3aMS79ggEydPZXEbB660cOKmZQdGlKin7iiCBSSZ2OMRMGvrvBCPUNTUEL6zhx0zqfLun2BhGWyVkvtsmG/M0T8/AE/d4XF7W2idIVi+0a8UqC+U3NwRVA8PkN/O0TmyIMKB1od+sYDjYMySmdRQ4ss9uHyEm1rhdOK7ihnlUGANNAJZlL1/SZEdgtM6N/wszy29a9s4YM+TigzgwgUfvIGUkw1kHS5mTWWSg5h+X6rsaH7NlhhzYeQ2wfnFCWB+TuGpeOedrCEC6aLtgdPO+d2Ua+iRyOMeHXUkEjOzdaZwGA8YfeeYqO04HKp/rZA1zrjxcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8nMlP0Bd+sMRxNt26ieURmVk4RmJqcN5LgFvyaSsnc=;
 b=TaCBgl5A5KpgnRVrigQz/mAnZokVy1K/X4utrk4d/mBfywMkgfZlpAvNg/Q2+Pu/bWKz2qV4XU9/nOTqj+CirkYOB0hw2UsEZo3cAAcA8v0Gtu1IdB7aIBG3GQLrtB0fwExAB7DaAQUyXwwf6c92tKEteOnkZAqZiuAG5wWaaBG8422ZjoBCQdXqwCF6HvggXel/YF+BXfQWBN4kyfG3RH+2Pj4puLkft5rhBREW59UWHlWwn5zEVeTvXO7WW1fPkzRJ5Oay0WJOGOv6zcVj/Gyj6HqbkzXOBZ3cEaMBWDM48+xL9R8vU1mNdCAu+pgCb8SgAfXwn8VizSHQOv15NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Sun, 23 Jun
 2024 10:48:21 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 10:48:21 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH 1/6] mei: vsc: Enhance IVSC chipset reset toggling
Thread-Topic: [PATCH 1/6] mei: vsc: Enhance IVSC chipset reset toggling
Thread-Index: AQHaxVBI7VppjHMoCk24B1sgM2LUnbHVH2CAgAAKRoA=
Date: Sun, 23 Jun 2024 10:48:21 +0000
Message-ID: <MW5PR11MB57875BB58B528BA00657007C8DCB2@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
 <20240623093056.4169438-2-wentong.wu@intel.com>
 <Znfznzd6Mt55XsmN@kekkonen.localdomain>
In-Reply-To: <Znfznzd6Mt55XsmN@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: f8f0a55e-f925-4028-cd19-08dc9372001d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?C0+EuDaMRevJXCSKpltyTes7WON2pLFMdG4ZKYu5Z26zr0yCCsXG6bUFsegl?=
 =?us-ascii?Q?UkqT2Bm9ZV43bzGuKHdzO+iE+68ePl4GUj7mpOUk0TpnCq6TgYqmjkseHxMJ?=
 =?us-ascii?Q?o7wJzFUZAecdCBR+eKQQC7olDUwCOXv4yYpadzQgfffhou3PdB5SVWPbpWSY?=
 =?us-ascii?Q?4iOZy0SaemP6I0aU42vR7ajKvhp2JEmG04TmoyWzcaGudrlkXWJ5Kut7grvp?=
 =?us-ascii?Q?4SLzJxHsWAI+X5HP+oqnB2ZQ8FEtgl/di2WbaQNQpEIH86jzArkfoC/vfDs+?=
 =?us-ascii?Q?gWpW9fJNvlNXKIlLWwyqLJONv50Qi4U6+ATHENKjREXLMua3gqYNH8IzdLq9?=
 =?us-ascii?Q?LRx2O6L9djm6CU9ClQn9HjqLvuBvPJA7G/uB+9F6PwoloeSGIxVfwD3n0Hz+?=
 =?us-ascii?Q?qHL01S/frp2mTvdBD8p3JVmTF0APbvZdTs8VrdlG5RTFJ0cCz8Gxv3GA7UQP?=
 =?us-ascii?Q?OJW2jRaU5b/SIm/3UwNJoqwmCM3gR72btrbLhwkdY455XjIERgcPSaW3XiZM?=
 =?us-ascii?Q?WJLq0H2BSO4KPugDFTTuPP2nAjSL0EFCQGnkmhLsT4iQSvU5jzQ6OhByXdLp?=
 =?us-ascii?Q?AM1fvUFTqPBbPfUGkKsPGSTNa8mVYVoW/QIxEsdHhmqQqQncpsi8i+aTAVbO?=
 =?us-ascii?Q?Q0v6LUIBq5QOSiwl7rL0ra0tKA92d/ET4wKeVm5WuLxvFFyEbtKbwBoLmsNF?=
 =?us-ascii?Q?dWoK8bf0uT5VHXgN5htptQvjijg2WvWD0nK1S396Du8vkjATuRxIBLnA/189?=
 =?us-ascii?Q?0wv29i0T6zeDWBQYCjHn7OgSHb1txutmmWtHuOw3hxmgrD7CIp4KKl0aNyOk?=
 =?us-ascii?Q?L6SVYxp6wu8PLCZyJA9D5B0wpEax3ZuL+Fraaz1xOmAr55hoOnSowCIVtM/b?=
 =?us-ascii?Q?ZIoFstNk9wSGe3ALV0jiX4tXaAnQupIHxHGApLQM5RPhv9ujmPpf3McRpwaS?=
 =?us-ascii?Q?L4qNv7pwdxAI6u309uheygh5APRDp314ASne5nks8HIRrbwdQWLIBa7Kiy8t?=
 =?us-ascii?Q?Ehzwev5aYXAg/3Q74isEGtVKQT0Z57eUi39vpYs54ygN87CD1o/LRyTbtfgk?=
 =?us-ascii?Q?7oYoO94CA/og9Y/6LtM/VzIFkFh/Eolp7EaDHOXByRKydGTGqHTY0uHm9UJx?=
 =?us-ascii?Q?Jhq4MsVmxbc3oeC86XHuG5Up4JQ3ZZJfhTRtZaa/nzfM5nw7rLlb8npGnuJ/?=
 =?us-ascii?Q?JBhFwTFKwFq/KREOKI2TUiDqvpVsuSYGDULz8wGgMDiNk6zAlTP6nejmODDi?=
 =?us-ascii?Q?OuD8UgIQarNu12DZXJ+O+sLjanhf4+/e21TFYI3Ik2LwjMuijy7mtcifkKmU?=
 =?us-ascii?Q?9GLdtzXWN04LQWhGlPYxckMyY75l2vsQPK5cbai0DskGFCa+oOMaw9gKw8Dk?=
 =?us-ascii?Q?SL9Msy4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyACBK7YFI0gwPdHFOUfKz1R3/LQBzBe077dKCZ6ynQlod1zqB97PGMMeVvZ?=
 =?us-ascii?Q?HenR5d/S4EyE1Xy+v21Q8pWNPAtnFh5ZTJBTGsq6JYkyaDBYqOYgyz1HEcvw?=
 =?us-ascii?Q?abPy4Hf9QXdcrPxTyOjZSluhJNAPI+Ie1G8DtczceA3zVm6+RRa/SaZbGj3D?=
 =?us-ascii?Q?xcbWFM2BksMo3CJSo6g+28LzLrdXAo404gsx/3KVc3/Z/U5ExZtQrzuwlFSc?=
 =?us-ascii?Q?JjPjsf+6vA5byonVQgV90FoqjSY9FNdR6y04hpaAe45b7ppJnD0p3jePQd7b?=
 =?us-ascii?Q?5jiwhagM+SthM2WMENFt4GuPLgahey2mnqiEniRerVxofqrkf/Diepkjolqz?=
 =?us-ascii?Q?VDd46xs47KfnkYRymg3zzA+/WdzxdcIiUGOf7AmDZFVM75MR25P6Ikg7BX06?=
 =?us-ascii?Q?jTQPoTgqcRQdN1umgQY6Se7tvHhCzr1PnxG7waJaYgVrqVzzAAIjrX2YS1f6?=
 =?us-ascii?Q?+ieDlJVkdlBIXnOmDUSQImwa8JSQ0XhRRYBUrTFawEhBIbj6E4rJggEXvDD6?=
 =?us-ascii?Q?+rhw0R+sbHxZCIQNpZcLRjSfwUk7WvOYdNrI1kUy0rTipW5wrjVwMdb2lFXO?=
 =?us-ascii?Q?SMTCDUnsdTxMd2o3iaJW5wan+fMgYsrU6/0KLYN4DjQZbtWyKOwF81lmUqtD?=
 =?us-ascii?Q?4x+9yymzrGaXHypSed43OQ3oofG4sI6W+Q1egejmWC74ylIhdYzDUZ9RRiRz?=
 =?us-ascii?Q?gDXZwezML0H7VJMGJMmZ79BG+ziCfG/M5+pmI2nRZI4zMVP15/060lWFMYzt?=
 =?us-ascii?Q?UJCnyQDmDRS2rfxQyqtP3pOLGGi/x/895/BWZbugM79dgZNBLDHz17+L4uj+?=
 =?us-ascii?Q?b8mL0dOn85FpBWAuTJnwyrYScx1WwM5RDpJvrYsl3maKwxBmCGj8P8EGYkfm?=
 =?us-ascii?Q?xjSmoGxZWFWYlr7+xLTs2AMSzZ/5lyrsfIvQpISHK+ZTVO/Hu0XeE83nxDoE?=
 =?us-ascii?Q?FznWfyt/y14mziFclmme68GuVDMHw/6o6CZmW579amcwHtO1nCxUDsfSd2+V?=
 =?us-ascii?Q?DxQJTDc+4ZM5XEjyeFe6OGgqg/yRlpyJQa7z1NRZguynuszk8Tn/XWsEl0qn?=
 =?us-ascii?Q?d0aDuqcS6kgdUq0azhqE5rl7qNoXyc4n+LqDqvrsePb3pzVf7twaf3fgWCU5?=
 =?us-ascii?Q?SF5rImgYabjkvfkpoqAAMWrBmQC5+3zwZmS7ITYKMSbZaEV2bS/EKUsKGd4j?=
 =?us-ascii?Q?NJtGhkBrRGP23gi6oaqFo7uI2UiPdj6guAfnSeyj6AMkwOTs3AmT9kOL8hDH?=
 =?us-ascii?Q?vb8jRW4fBGJi/sdC4IN245Y9/ADOHjnh62lZx4dorfkZ8QG9BCTgZM41sFKK?=
 =?us-ascii?Q?H2yQx+Tu0y3ON/CNTWKVRBmN1VEjk659s3Dpp73f1OHg469L14zBG15gsdxa?=
 =?us-ascii?Q?kixekP5hkATAbrQ8rnK7taivk5tcPCddvvsxuQcPsN84TqOAnXrG0SYv/slY?=
 =?us-ascii?Q?jqkvD4ctQv/MXz0/4sDUbq8GPEB94iw1AzqBiR/sUP4s6xOBol8u9en7bQFl?=
 =?us-ascii?Q?xW85bTZ8xRpUdXB78t3jybepg+2gKdP4VUs92spsPeUaRsnI3ZOX/P3lmrvv?=
 =?us-ascii?Q?NsYgzOGRwHuvmSrGchdX2Nd2/vBjxyS19frqOxsp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f0a55e-f925-4028-cd19-08dc9372001d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2024 10:48:21.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sz21jFLXZqRPb7uVt79TYeQfU0KObdxjji/Cqb29cnkcAh4OzLPrg8lyKNsswiAZVWNvKRveOM+WD1bCj9tZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Hi Wentong,
>=20
> Thanks for the set.
>
Hi Sakari,

Thanks for your review

> On Sun, Jun 23, 2024 at 05:30:51PM +0800, Wentong Wu wrote:
> > Implementing the hardware recommendation to toggle the chipset reset.
> >
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Cc: stable@vger.kernel.org # for 6.8+
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Tested-by: Jason Chen <jason.z.chen@intel.com>
> > ---
> >  drivers/misc/mei/vsc-tp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > index e6a98dba8a73..dcab5174bf00 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -350,6 +350,8 @@ void vsc_tp_reset(struct vsc_tp *tp)
> >  	disable_irq(tp->spi->irq);
> >
> >  	/* toggle reset pin */
> > +	gpiod_set_value_cansleep(tp->resetfw, 1);
> > +	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
> >  	gpiod_set_value_cansleep(tp->resetfw, 0);
> >  	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
> >  	gpiod_set_value_cansleep(tp->resetfw, 1);
>=20
> Looking at the patch, the driver appears to leave the reset signal enable=
d.
> As it currently works, also the polarity appears to be wrong.

Ok, the reset pin is RISING trigger. Probably we can remove this.

>=20
> Could you addrss this, after this patch?

ack, I will send v2 patch set.

BR,
Wentong
>=20
> --
> Kind regards,
>=20
> Sakari Ailus

